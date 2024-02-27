Return-Path: <dmaengine+bounces-1122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B7868933
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 07:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21001C2182F
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC457535B3;
	Tue, 27 Feb 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="aIzL09UB"
X-Original-To: dmaengine+unsubscribe@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5801E4AE;
	Tue, 27 Feb 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016744; cv=none; b=r2Pg7mDacyK/GEWZ08OucnXwP7FrHc15fVtsmvv26iE70/xm7+unOT9L2w6lnl/OW47r8p4i8UuwtX/LYghRR8VfEWjwysrBAq+kkbjKYEVF0zsz4nI0CKozF1gGSIkTXch+p1MLy+dby8EwQSXY5dHjynw0RuV2MOXHo99RAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016744; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:Content-type; b=O64syhZNym7LsxdYksAm38oa0a2YTW3ieA6kxEYsnFLdWsf3tVZuE0ICQuwtNdUlyXTjXzZENAw3HG9SN6bfXyWz18E5aWMtsrKQg8OrX08nGXk2rkSNHsdy89GSTCBq00cBqTbHHgt4pZbI2VdqVt2ZKUGBrDQhBvckrZLrlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=aIzL09UB; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Received: from [192.168.1.94] (45-23-117-7.lightspeed.livnmi.sbcglobal.net [45.23.117.7])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41R6qJT0030968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 22:52:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1709016742; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:From:Subject;
	b=aIzL09UBo6WZuOOi05cac9INBg4UZ2lS0I5Er43k8oWia8XW3LuR0k43cJAlUJequ
	 C7ep900tsEVbjXDROo3D2Q/Kkg37trB5y7gBz7y/duBhZoz6rd7h3Cxg6p74G1x5mU
	 Fj5PgtgpB40cm6X0hzqr/eDQhbDfEtCknrIt97z44aQ9hB47E0vR3p7RjaitqQVmO5
	 jxgDNPFLsGvpUFTaG4g6M9HIWo+P529+7qoPwLm5aL6DpOMoBetIGu/nTXUmqC3blJ
	 qRAF2l7yQSlagk2bZ/6ctg9BDKArKzNdn8FPO2UShOMuagVryll30OrxJaP1LeNpcK
	 SEncqoL4Z4GCA==
From: delyan@sonic.net
To: devicetree-spec+unsubscribe@vger.kernel.org,
        devicetree-spec@vger.kernel.org, dmaengine+subscribe@vger.kernel.org,
        dmaengine+unsubscribe@vger.kernel.org, dmaengine@vger.kernel.org,
        dwarves+subscribe@vger.kernel.org, dwarves+unsubscribe@vger.kernel.org,
        dwarves@vger.kernel.org, ecryptfs+subscribe@vger.kernel.org,
        ecryptfs+unsubscribe@vger.kernel.org, ecryptfs@vger.kernel.org,
        fio+subscribe@vger.kernel.org, fio+unsubscribe@vger.kernel.org,
        fio@vger.kernel.org, fstests+subscribe@vger.kernel.org
Date: Tue, 27 Feb 2024 01:52:18 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: subscribe
Message-ID: <65DD86A2.17414.445FAC2F@delyan.sonic.net>
Priority: normal
X-mailer: Pegasus Mail for Windows (4.80.1028)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Sonic-CAuth: UmFuZG9tSVaRmDnAe7qtFHsZVmHzmJDjNevSWY0HV8jKPtCRUAwJ+TCTxvo2u3K9QUnWHsh5kPTFmtp1BqTK3JZAz6HvHW69
X-Sonic-ID: C;Cr9LwDzV7hGbeC5nR+6Zsg== M;+qk9wTzV7hGbeC5nR+6Zsg==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

subscribe

