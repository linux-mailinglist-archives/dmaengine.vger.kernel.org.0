Return-Path: <dmaengine+bounces-6537-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D6B59A2A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4D24A2E7A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06AD34572B;
	Tue, 16 Sep 2025 14:23:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62C1EA7C9;
	Tue, 16 Sep 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032613; cv=none; b=uroXQSk96YXz41YHYJgmFlh0pZQztz37qqxorS31hVdcUaN1Rs3ULFjowP214XkDmvkm/MoMALe4A93hqv6dDU8PGCms9xscNImKbPwu0agg/IYPFUdbg7OCwrxRP3Gafptt+ULgC4ncZtHnjmW9NU7aM0kCLpKO1b6e7pYIzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032613; c=relaxed/simple;
	bh=laG34OI5aRJEKziwE6DGlP/kwHfOb56m92sDzA8x33U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6UvbpofeUCv04vFnFRRqqA60Z+0on8V+HGWkkv+XqkCyBQok7sNxwMeDD5frbn4a+vjbPnCX9M54z0DUjlzz0Wn5DKze2eOC6+q/LaUmTg7HgSPxpjSN0CEGRxbcX6nUf9jrhmamqClTbDUMXqgFOvl6UbA3uJAFufw4F/ON+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR3xg1yVnz6K9NF;
	Tue, 16 Sep 2025 22:21:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F849140417;
	Tue, 16 Sep 2025 22:23:29 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 16:23:29 +0200
Date: Tue, 16 Sep 2025 15:23:27 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch <nathan.lynch@amd.com>
CC: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>, Vinod
 Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario Limonciello"
	<mario.limonciello@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 06/13] dmaengine: sdxi: Add error reporting support
Message-ID: <20250916152327.0000335c@huawei.com>
In-Reply-To: <87frcna1mq.fsf@AUSNATLYNCH.amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-6-d0341a1292ba@amd.com>
	<20250915131151.00005f26@huawei.com>
	<87frcna1mq.fsf@AUSNATLYNCH.amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >> +
> >> +	/* 6. Program MMIO_ERR_CFG. */  
> >
> > I'm guessing these are numbers steps in some bit of the spec?
> > If not some of these comments like this one provide no value.  We can
> > see what is being written from the code!  Perhaps add a very specific
> > spec reference if you want to show why the numbering is here.  
> 
> Perhaps it's understated, but at the beginning of this function:
> 
>   /* Refer to "Error Log Initialization" */
>   int sdxi_error_init(struct sdxi_dev *sdxi)
> 
> The numbered steps in the function correspond to the numbered steps in
> that part of the spec.
> 
> I could make the comment something like:
> 
> /*
>  * The numbered steps below correspond to the sequence outlined in 3.4.2
>  * "Error Log Initialization".
>  */
> 
> though I'm unsure how stable the section numbering in the SDXI spec will
> be over time.

Always reference sections by name (which you do!) and version of the spec
for alongside the section number.  They are rarely stable for long.

Jonathan

