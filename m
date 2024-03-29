Return-Path: <dmaengine+bounces-1656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E9891C4B
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCABB29534
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048CB181478;
	Fri, 29 Mar 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="IN2aA162";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCbueiqL"
X-Original-To: dmaengine@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE66181316;
	Fri, 29 Mar 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716104; cv=none; b=DerISdmR63tvMzSivP8X51aIMS0lVhfBYMIXRGSRDEKSw/GZW+gYfa+65bc8RkLC1O3Yy9Cr2IhBdNN1tlt8Zur3+rxnbsUDq6cROFSEXfxyjBZoGcHOQcTGSa++Uev3Edfp9DGACi47jZzLc7weU06C8bCH4XLq7WE7gLyRNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716104; c=relaxed/simple;
	bh=Zl4uY056rn3oCq8BYopiJq30V4qLF00RQLUPIhNP+7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWd2+JfoP8gKkOPXMckW+OqE5WxNCfXJ6kC2wuVcGVmESAVXHXv4m1ZTgQmhwLmzmvcWMYBG24rCJPF/3qmA/zkgDLAHG2Kb478YNB44SDIUfMeCQEXrouaIDpRf2Y0ZPTkHOzZerzVH67K26i14bScL9eRxxzqjhTZEK8EhBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=IN2aA162; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCbueiqL; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id CACC05C004D;
	Fri, 29 Mar 2024 08:41:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 29 Mar 2024 08:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711716101;
	 x=1711802501; bh=8t+Ooz9N0keYiRnoFQLVfdESXvr9KZsTT+8XDp+LVHw=; b=
	IN2aA1626fLlJJJz3uPDKlJYEuGJ/afleFjjFRL2a8XAbQdHOOuTSp2M2cfUYCOz
	ZGORBR6+LBeX1wDMjglfPZn+ERR4TlglkVCQkLHamYEMao0DJwQug0P7KUtXlFoP
	/ImzUBCYACG4jRWWptk5+kpXvgb4h5/F6iw9FZ1J95uO3YWkApsj6Cq/F026fAoT
	m4aZT8IWf25JA2eh3KkvjW8f+WidxXVTleqAgZIQw0TeyoQTCBu0jEj4UvquNNIG
	nc/WnHKBCyvrgU5plrByCnX9fDr8FrkE8gjCePD/sSA7ZRE0Ui9mnBfLbpWlGjoU
	7bjExy0dyc8FHEiUysibAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711716101; x=
	1711802501; bh=8t+Ooz9N0keYiRnoFQLVfdESXvr9KZsTT+8XDp+LVHw=; b=U
	CbueiqLtnzNLU8Pdm4XWA2AeThNgvcHfVN/jKDNbUco1DreTiHiXW86geaaUoK79
	IabSkW8tDTNXVv85E2H7ym8GnM1MaYw6tTKXb1PyalKyzR0icVWKysIf2tPDc2OH
	3PnHAJuft1Se4OkKoSEm+7DH7mtec7XaOQK8iiQTJcmq/R5ovJqp+1GvpnhwOAtb
	1Sr2hN7bTTD33aCwpiquwwULGLhodmbhAePNmhXCpxq6UbsHhnodKNzMjYUGj1X7
	zfCDRwNfDn9E6051qjYY2/e4hpaRpSMaRlKDK+qHxicShX3JS6SonQiv9bVLs7xt
	JUk+RjF8Tz1dQfvPOPtjw==
X-ME-Sender: <xms:BbcGZudfTj8qjLiKpKJmuSnz0NHDk2qcfEwMAIhSGwfVBUBP41c4zQ>
    <xme:BbcGZoN7cmH0LGxNsTfZu-SJArnkfT0NNZDpka3T1BWcl2rkGvCnLqIRxHgI5Inzr
    Zh6ZrvTVEeDGYuFZFc>
X-ME-Received: <xmr:BbcGZvig2sZ_1rvO-thErU4g9iCflGa2buvXUja50g7cYP2uAiuYWcihBEc6CsYr5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudehjefgtedvkeevvdevieekleekhfevkeevleehieekfedu
    teeuffduhfehtdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:BbcGZr_FONH8ap0ljgFSH-ZoDlpYEG013DTczMg4CQ2tB02-bdb5mg>
    <xmx:BbcGZquQLUGKXsHNq8ovUyZWrOul0TEL71vBvoSgB6PqZroCF1xDxg>
    <xmx:BbcGZiHX6tiFcSe1XesMeW11LLmAvuv7shGO8r_IKwdJxQGc-IwQow>
    <xmx:BbcGZpPQTrz9fryKwMK2ghGlj6Xrb_iSfQ7F99AKOQXVI361nhMiFg>
    <xmx:BbcGZrmjlSVhNr61VYT-lt7wHQr-Gbi9javPIVISOhsEDFSBrrqOfw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 08:41:40 -0400 (EDT)
Message-ID: <7da03e9a-051d-4537-8405-a645610fe16c@flygoat.com>
Date: Fri, 29 Mar 2024 12:41:41 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Add support for Loongson1 APB DMA
To: keguang.zhang@gmail.com, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
Content-Language: en-GB
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/3/29 11:26, Keguang Zhang via B4 Relay 写道:
> Add the driver and dt-binding document for Loongson1 APB DMA.


For the whole series:

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks!

>
> Changes in v7:
> - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Chen)
> - Update the title and description part accordingly
> - Rename the file to loongson,ls1b-apbdma.yaml
> - Add a compatible string for LS1A
> - Delete minItems of 'interrupts'
> - Change patterns of 'interrupt-names' to const
> - Rename the file to loongson1-apb-dma.c to keep the consistency
> - Update Kconfig and Makefile accordingly
> - Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com
>
> Changes in v6:
> - Change the compatible to the fallback
> - Implement .device_prep_dma_cyclic for Loongson1 sound driver,
> - as well as .device_pause and .device_resume.
> - Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
> - into one page to save memory
> - Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
> - Drop dma_slave_config structure
> - Use .remove_new instead of .remove
> - Use KBUILD_MODNAME for the driver name
> - Improve the debug information
> - Some minor fixes
> -
> Changes in v5:
> - Add the dt-binding document
> - Add DT support
> - Use DT information instead of platform data
> - Use chan_id of struct dma_chan instead of own id
> - Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
> - Update the author information to my official name
> -
> Changes in v4:
> - Use dma_slave_map to find the proper channel.
> - Explicitly call devm_request_irq() and tasklet_kill().
> - Fix namespace issue.
> - Some minor fixes and cleanups.
> -
> Changes in v3:
> - Rename ls1x_dma_filter_fn to ls1x_dma_filter.
> -
> Changes in v2:
> - Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
> - and rearrange it in alphabetical order in Kconfig and Makefile.
> - Fix comment style.
>
> ---
> Keguang Zhang (2):
>        dt-bindings: dma: Add Loongson-1 APB DMA
>        dmaengine: Loongson1: Add Loongson-1 APB DMA driver
>
>   .../bindings/dma/loongson,ls1b-apbdma.yaml         |  65 ++
>   drivers/dma/Kconfig                                |   9 +
>   drivers/dma/Makefile                               |   1 +
>   drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++++++++++++
>   4 files changed, 740 insertions(+)
> ---
> base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> change-id: 20231120-loongson1-dma-163afe5708b9
>
> Best regards,

