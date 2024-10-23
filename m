Return-Path: <dmaengine+bounces-3418-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D19ABEC7
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 08:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8B28511E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 06:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720DA1487DD;
	Wed, 23 Oct 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iGpQUzuf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D127452;
	Wed, 23 Oct 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665127; cv=none; b=iRmJP98DvFpzXIGQhWg0NpXU3niUiael3tSz/rC/Jgw7LEMlKG+Xy2jjaa4gk08XKQCxtUVKiVTaNkr5BPayyraA8SNKdM+De4M1n9BaRmY7kvXy4QH0Z3QKGwgq83dLU382UXuNnilQAQ9KdIyl1sowy+Lddq47lJlLUs8sj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665127; c=relaxed/simple;
	bh=ngQUyspk0u5tmnuw4tF5HJKltqCiL9AJbZfUWTdGVNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqAljj8fmHdDyFdoVmA1FP288LYiMEy1EbIUQAuSzRrGeRBwRLefGLz8QHoNqUUN2KkWDn4bV5rAdxrFl8S63elr2rGMiw6h9lX0HAblHnU62os6fTA66AY86N6vLgUNq7gAiU3LpBWqouLvZgw8313F7JRYiBsPd8b+Mo4lemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iGpQUzuf; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729665067;
	bh=ngQUyspk0u5tmnuw4tF5HJKltqCiL9AJbZfUWTdGVNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iGpQUzufGKagQD2p8OJ9+o1rv05GO3s0irkkzl+B/jVQzK62CKg8qVz67X69ysnlY
	 guTCSgPYkdN689aKc9jSkAv2q1YkVkLU9aW1hyxIu8y95ubUmp7oLbbBrYPzSuQtxk
	 b6AP1aH471/Gf/Mf0lCx04AOx9Z8n7u1eTbhDMCE=
X-QQ-mid: bizesmtp85t1729665063t7rgkpzf
X-QQ-Originating-IP: /Pu5B/BFVMh1l61DmVeOAJ9BOb/PIqdl2onMEJbSJ3s=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Oct 2024 14:30:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5490330265754036757
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: patches@lists.linux.dev,
	nikita@trvn.ru,
	ink@jurassic.park.msu.ru,
	shc_work@mail.ru,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	fancer.lancer@gmail.com,
	linux-hwmon@vger.kernel.org,
	dmaengine@vger.kernel.org,
	xeb@mail.ru,
	netdev@vger.kernel.org,
	s.shtylyov@omp.ru,
	linux-ide@vger.kernel.org,
	serjk@netup.ru,
	aospan@netup.ru,
	linux-media@vger.kernel.org,
	ddrokosov@sberdevices.ru,
	linux-iio@vger.kernel.org,
	v.georgiev@metrotek.ru,
	linux-mips@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	dushistov@mail.ru,
	manivannan.sadhasivam@linaro.org,
	conor.dooley@microchip.com,
	linux-fpga@vger.kernel.org,
	tsbogend@alpha.franken.de,
	hoan@os.amperecomputing.com,
	geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements.
Date: Wed, 23 Oct 2024 14:30:58 +0800
Message-ID: <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024101835-tiptop-blip-09ed@gregkh>
References: <2024101835-tiptop-blip-09ed@gregkh>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ns4o82esMDegcnRCWZU/vtwwA13F4B7+hQiq+gV4rNIZds3XaHCyoQOa
	p1fmo6vINY/HzKP8exUDEUoT8GO1mhMuqj8+qpo5UC+JwPE3OWM7p2tc37xsKL0Rflb2gvg
	3g+rXbHOOHjoc7udEIyiRilr8qSndIj44+lmU2xp1cmI4vs85wz+CmAay/MLBHgTu8VSDav
	18VxAAE8Yd2BXdS4DJgxvsIF4uLWcfuKQ18bZt6QN4PuMS8nErrVaThJbYmG6ZlX+Zs5jdj
	hp3T2WOqIhf8Xorib4KNQwU3I00j3FEZmlokVC/zrWW9NeSBwAuw1H/FtCbuQFejMKMxKcF
	C1ko/yI73fKK2fAloS9N1DbwAUL0de2oXLE/HRPaPNLjnIZ0c/O1Mwm0JeiYTCVjPpiRaO1
	WaRrYhmIGp76sLTGrJeyQ2xDXW9TP+H11ZhkS+PWc2xc6HCivXkBXtOcQJHn4uh3Llh17Ps
	dOnQZUopL9EgRdav9yavseoCFrTqbujsKPRWmiQNx+be6xlFi/GPWpHdT6opgiBhDECxI9o
	CHJjdm3dxDPTTXGOq4UlF8henUED315eWa/m7+YiU6j4HTd/mEtyKf8XhHcF/PjZFoRKkFb
	3i3G6X2XmnG5ko/AkhJ5GTUnLEKf5Ex4xqNVJJFUno+YAzzh+q0vy4NMoPzAoqrkoNf+y+G
	E71LDKQsbTd61QEDPqjfp0TDuF7UHoiJoewWDckjzR/X7LHJ5L5a6wNLtsPt66laf3rmGST
	Jp4DiW65HQUeS3wsDAiDAqm30JuVGYGCcRZzjdcaNJnZOF0ur8qUZI9WqxiAMYXhF+EeQOS
	+3bSV7qiBCvev2SyMI1xcUevIwqfQoO7WfTH0Xi8u/a98aKNBMKOvefCOOsOYFbhbY38S8M
	8FMeZiYtkAp3ngJsZfKMB6mfHqlo2IfaoyvmPXJyuJ1dsEgra9VXPsTwai42iQ1ykdky6Uw
	gTs6Rdc5VI7x7lU95r9nZDyPv
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Although this commit has been merged, it's still important to know the specific reason (or even an example) that triggered this change for everyone here, right?

And those maintainers who have been removed should be notified.

It should be CC'd everyone who might need to be aware of this change, including the removed maintainers, other maintainers on the subsystem, and the subsystem's mailing list.

To ensure transparency.

