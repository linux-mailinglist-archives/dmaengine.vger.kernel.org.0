Return-Path: <dmaengine+bounces-4474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98689A36433
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D62E16B8D7
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED3189F56;
	Fri, 14 Feb 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jtJCRgju"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4513C9C4;
	Fri, 14 Feb 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553355; cv=none; b=IYHAilafjuTKAsJTn7nJiX0y+9wT0VljEcqHiaK1BI8gy43uIb55XtTqok9L7lqu9pwfn32Yc6od9SDzbR/Fuh6831J1Lb84YKP6lYmIXhKTrhk+Z4v6kURC7W+KPm2IvLvUPfM/NFzwRmP/Ns0g3g6ZvzzSNI0gS01U/wWCQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553355; c=relaxed/simple;
	bh=vccSr8pmvhKTmDUQzCWHzepzZm/wzNi0JuvKQSfKjGA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eYmCPQer7gjtzAJAcHWj047A98P7qNRJFP3t30gNsJ0i282PVx7GG7Tb6Fb/d435rpUJlvH/yeuYPBC52P+ZbgS3HeXl1A1iKzhyhrt8u1R8RWubUC+gi8vdtOxG/MIxtVeb3PWJ12+ToPk+t3JF4I87K3MACe2b4bXoX3EXlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jtJCRgju; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739553327; x=1740158127; i=markus.elfring@web.de;
	bh=lwS2ZzFp7liniJUkc0A/L4LAOMPpNI0aac7Xwd4fyLI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jtJCRgjuhH41Ay7yYOapIqgQHwmmDUNJtVBzHB2PuPqn4pxh/z4YXHj0lFYVmi35
	 qRmfHtTo+uq2a2UoL/JIcO4du35vh74H6H2hYALk0yC3orO/juQgiRErraw0/hu0O
	 IjhEYLBxG3GHZS13MRb2tAtncnvbFSqndl+uWPiAlRx4jUYiw2O8kYodKNCNDg4QU
	 wtO/ppyZnzwjeq5flaRp1JO3w/50acOlkjrHSwOV9mdXsFYfBqMJr1bXGDZ7K7Z87
	 H6bU5ctOAGeLL9m3u7igpI1ezVxV6dsTyv6F9Qm1XiRwL8tRxMyLcCj3wQAfwVkSf
	 KNQqhhFovDC5LAgSdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.37]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1t7iel0oRs-00he6l; Fri, 14
 Feb 2025 18:15:27 +0100
Message-ID: <61c9c416-711c-44dc-87af-b1aefc76b87e@web.de>
Date: Fri, 14 Feb 2025 18:15:10 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shuai Xue <xueshuai@linux.alibaba.com>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
Subject: Re: [PATCH 0/5] dmaengine: idxd: fix memory leak in error handling
 path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:otowLDbOeMQNkXg/a1l+bpJ55twBGxEOex5aHmPcBJBwb9kbIKA
 +bSKZNDQTZw9l0lU/LWTURBQ6d0YZPewEpntKObx/poLr6rHecgGHaMBjPKq34HhSYWqHUi
 Er0fLyUwDbI4xwDEXuoETelhlJDPgRn3WXBBLDX0VRG7le6PeW+rZwM0cf7WB4RdxHmIADc
 Typ2P48oDSZ5OWmgn91ig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3l71Z7hx520=;e53V9J7Vs5VS62PKg7BO5JVw2cq
 uaFdGE2TF++9hMY35V+kAHfKAUOU59VOrWmlDPUamPdRH39UTE3PZJscCGZ7tOVe73KZA0ZUu
 HDqNWNeaJPbqpdFVLDsJUNVDhDTp2zfMVl8vzn41JXeIw946UcB6PU48pMaSEeVIxOWhoIP2P
 KgPYxbMzW1rl3XskB2isfvhvX7ySZM286sJe3Kc0XeXxxX9+L+C0nO7WmSFkhNfGOzZFOYVTj
 4gU8obc+nuiiScnDtmaX53jUOILMYbwYihlVyEhwLhzicVWpXylCT3fwZNokU+TtN8WKbzxkV
 n3IzlOnRkRypAGvbH92cNnzTCR+07ELYdm0u8PbFqhwyWkslObIn4qwuHOpbUam6EQKJVjZly
 hQrcg/mbhpPHjc/vCPSdrXHCNnFFopax6bOqUpHiHB9kLwCY9on7//EVOCFMgljgKe+L5ny1t
 WdVCZxTygCHYyrhRG4/FVgdV8YrKB6GvhWQmCqjjOGeF4TtiZCKrW/xZ8GxVJmhLsY5xooikZ
 qKUwZWNdTl1Fr30o2qTqCazQPsPVCYyMRNpLvCivfZ9lu3HGwlAfmpQQGlbtURPeEi3WbRBFi
 voczvTJDsasONeOQafRmCreYfXJM/PZ20aaoHO73/G1ulLKp4TEEittRWePBYJ6aSRX+aglYT
 Ks5NL1QU3KeYZcmIg8LF3ZNfhwo/VrFolVTgxTsvNcm1d7KvuvQW3Tccb6RTlJ8W6KOw/OkUE
 vPefeSAOYRP9HsOtEDK0P1nLWtpFKBAjVslwK3VLcOn0XhrImzT1gkiNmxYBMeFierzCQah5P
 laxByAa/ISSQ7lsn2YioDYWQ58cfuQv64g4Xvz1du0uLuxxtm36QGjQZKTnzYBnwmRvSedMVS
 wLQ372ZwGqF0xZLwNs2zISu6vg70dyC+0eGQZGSm51pVDfWMnMdGMHgL6f8vjpYBZtoa5UC4x
 1Ov0b+7w38WflheS+hf8IYgRE51uWihJPs1xVln7zh5qqewb/X/XTEvISVx2bktp4Wg5UU8M7
 h529rL9Yyj+91yxeIzz678RV9iRFmxVk/XNSad85N5NQZ2Tjg79tF0B/JC/ijxJZpf9tq3Cy+
 sG1dC4u1lb6KvbPALXqmfkp/fD7RhOdRbZ1usDVhejOfFoJNLLM73mo8fj15D3tXA3INdSiPK
 JlIZWCJFi9BIN62COsmkWUemBadNpcmu50t0QQt//db/756DVjinNqcq//aytni5FJqlw/6pf
 VEO2zRel5CnzK9J4URBrfgdbVX576yB0MKXMbsEmGuOmiuuVibz7qL1h54gPUbDrYT6Sn/YLy
 +09KpFQMTlwBNsf8btku5jKNUBJG+e9yxiBlKviUT8qX4kEHVHPT2aw/MC9jJDulUdIClKvwg
 ZkZccG6IjGKb8Ia0KDb7AmOHgDdREOoAsj0gBz6kbWbHWg8Lp2gaTGfgxD+ulemeoS0tPa3Do
 DQahP3CpveiQk9/I+iDZY4e9z10k=

=E2=80=A6
>  drivers/dma/idxd/init.c | 62 ++++++++++++++++++++++++++++++++---------
=E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D)
for the presented patches accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc2#n145

Regards,
Markus

