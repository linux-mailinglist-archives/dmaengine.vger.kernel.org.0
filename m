Return-Path: <dmaengine+bounces-1606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059F88F90A
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3689C1F27C0D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98133FB01;
	Thu, 28 Mar 2024 07:44:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from 12.mo581.mail-out.ovh.net (12.mo581.mail-out.ovh.net [178.33.107.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A824C62E
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.107.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611884; cv=none; b=KEjiR3XgCPrbGZM3zI1LDlAIeJmpHmHa6ZL3oF6sr4QG8PTPCgYdwdw5DOx+o/Ib9BTI6f5eslV0nI9kv9zGWWEif8NqsGtu3adYxgv2ixBJzGfUgcQZCyhES+q61u4Zc/ofkv8LaQ3v00YgL/Ot03FCscJoV8vbB6VQuuG9+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611884; c=relaxed/simple;
	bh=FoK+TTnkZBEIxAuqwtZNUFYhYqEUw8/IIA5uwrrKnQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TMe6Ldj1y5I3RvnSSzyEr4ezUXQlURAtV0+1qB0o4xislxz9pdNa5ExvHqGarq0EBBM80znUgfic324lkDIb7tw4qdGyr9Nw0OLOQtu+YWKoNajjWG74Pc4c5o1IHUeAfiVQasFOB/zHMo46ctCzWSwK6mzhNATnnoSemv5gRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.33.107.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.9.167])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4V4wMx6nWRz1F94
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 07:36:45 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-ldk78 (unknown [10.110.96.65])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 92A881FEE9;
	Thu, 28 Mar 2024 07:36:43 +0000 (UTC)
Received: from etezian.org ([37.59.142.99])
	by ghost-submission-6684bf9d7b-ldk78 with ESMTPSA
	id irrGGgseBWbkIwAANZbBaA
	(envelope-from <andi@etezian.org>); Thu, 28 Mar 2024 07:36:43 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-99G00369bef739-e97a-4666-95b7-831df257c96e,
                    6D693167F0AB1D8A9C15294DA3267AC24BED3ACC) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: konrad.dybcio@linaro.org, andersson@kernel.org, vkoul@kernel.org, 
 wsa@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: quic_vdadhani@quicinc.com, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240313052639.1747078-1-quic_msavaliy@quicinc.com>
References: <20240313052639.1747078-1-quic_msavaliy@quicinc.com>
Subject: Re: [PATCH v4] i2c: i2c-qcom-geni: Parse Error correctly in i2c
 GSI mode
Message-Id: <171161140136.2698925.4294566764047886777.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 08:36:41 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 2165386998096661243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepffetheduffdvhfdugfffudfgjeejudehheegfeeguefhieeugffhgfeuffdvgfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeelrddvudejrddutdelrdduieelpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht

Hi

On Wed, 13 Mar 2024 10:56:39 +0530, Mukesh Kumar Savaliya wrote:
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

Applied to i2c/i2c-host-next on

git://git.kernel.org/pub/scm/linux/kernel/git/local tree

Thank you,
Andi

Patches applied
===============
[1/1] i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode
      commit: 394b3e3ead0d9fdcc1ef53bb893fdbe7bf1db3ac


