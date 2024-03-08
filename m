Return-Path: <dmaengine+bounces-1323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB9876D5E
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 23:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91702B21417
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566236AF6;
	Fri,  8 Mar 2024 22:56:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from 5.mo560.mail-out.ovh.net (5.mo560.mail-out.ovh.net [87.98.181.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3F36139
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709938599; cv=none; b=RqURb9+5v5yPy/iB/ut/wgoDrtX/OJeuylMhNF6rYVuclhp5SklyYykuKY+YwjBuZx6Xz+F9Hbz94IXjvaOOJe+EYtjByXmNwJSvSOocSa4R73gQllX2haZdnh4XwMA6BH0wAWtaffMHpMga9f1LpXsnGWFtmYjCM5pFn372EdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709938599; c=relaxed/simple;
	bh=ea/FMOT+LuvBUIf6Z9oNmYg5v6oX6zLSUSAj65JmdWo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o0VxPPGI2QI8zgpe3VNWZTW/y+/aCAh0z8HH2WSBVCk/Zuc43gp6FVZhPcWcNb9FoQZmEm18xDA8uNM6gPCJF0D1ifGklnOZXDrLAYbwhSCHqNhbbCcdxCaOuOk+TLBOV2ljIHrAI9KCQdC+/k6LigpAyivJjtlUHAJS30o3H5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=87.98.181.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.2.211])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4Ts1kV4cp5z1NLH
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 22:56:34 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7mrq4 (unknown [10.110.178.91])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0BF541FD79;
	Fri,  8 Mar 2024 22:56:34 +0000 (UTC)
Received: from etezian.org ([37.59.142.98])
	by ghost-submission-6684bf9d7b-7mrq4 with ESMTPSA
	id 53omAKKX62XQVgUAplAmPw
	(envelope-from <andi@etezian.org>); Fri, 08 Mar 2024 22:56:33 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R0028d618e52-d2b1-40c7-9d69-95ea762b9783,
                    2D11F706EFA52336831762ECFB2C8F5C1953C755) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: konrad.dybcio@linaro.org, andersson@kernel.org, vkoul@kernel.org, 
 wsa@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: quic_vdadhani@quicinc.com
In-Reply-To: <20240307205539.217204-1-quic_msavaliy@quicinc.com>
References: <20240307205539.217204-1-quic_msavaliy@quicinc.com>
Subject: Re: [PATCH v3] i2c: i2c-qcom-geni: Parse Error correctly in i2c
 GSI mode
Message-Id: <170993858923.2618408.4667207790973009000.b4-ty@kernel.org>
Date: Fri, 08 Mar 2024 23:56:29 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 10926295649741245147
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrieeigddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth

Hi

On Fri, 08 Mar 2024 02:25:39 +0530, Mukesh Kumar Savaliya wrote:
> I2C driver currently reports "DMA txn failed" error even though it's
> NACK OR BUS_PROTO OR ARB_LOST. Detect NACK error when no device ACKs
> on the bus instead of generic transfer failure which doesn't give any
> specific clue.
> 
> Make Changes inside i2c driver callback handler function
> i2c_gpi_cb_result() to parse these errors and make sure GSI driver
> stores the error status during error interrupt.
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode
      commit: 313d6aa4c64875ed8a10339a2db8766f49108efb


