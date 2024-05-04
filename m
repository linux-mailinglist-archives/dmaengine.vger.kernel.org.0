Return-Path: <dmaengine+bounces-1986-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880608BBC6C
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6251F21E9B
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4613B293;
	Sat,  4 May 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="O+Cinq1G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CF381D9;
	Sat,  4 May 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714832882; cv=none; b=nFv0iz7/3P8a0Qw9XCsHdF+XR6r/MRYFrDWyRXmJzzTF+3fWsIb6vgTwpRXI+/ruDH7ClJaONzSVoFL/ZCeZBlH8u77irKlQkAjo6R0ISzp0/ZAMbSyRxQEb6EVBmKsWnaNs8a3AfbuRIXhOyeDhFSRIStGeIa5D7bR09ES7uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714832882; c=relaxed/simple;
	bh=HwPv9+AKMyHTHzY4fmj1exHYqsjVJIW4ECxeKr4NcwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEvxL9VbAvk1U2iebj6txM+e/nZH0BqiiPW16gtQN3vfzrWdZAGsqK7tv3BhCngdPEA3qkUjs1IUXj111DE9AwD1aV/9Fne5qtHrr5hujhXVl435kZSc5N5wLOPGKt6RFYWhVtS1zULE0qn2ZDxYkYLunFrJmddZD3+tzrbNtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=O+Cinq1G; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 3GMjsEyZGuPiV3GMks2HSj; Sat, 04 May 2024 16:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714832877;
	bh=RqYKhXyxQzsUalkpz50XF6z0vFeF3FJ712ZCIzLOHG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=O+Cinq1GHFo+jJb97aeSNFRGj+H8OP8dSpV1RTewlr5gqGFWj53U9nVBYsLVvR17A
	 aYOjbdrUmOsjkOoDotHQUmjYU3Eau+pmDq17bSYJHRJRtJKFy3jcUsqF5RNTc+ZJeM
	 rgb6nt8YEfd/qknPKkLPGrOD5NrrNPFxuOilOnYZLx3kSn4yul/Is530EWIv8UT3kP
	 Inj4NRv0/vpB9qdqvD8hZaqfWayVMZrgYvbkcl1rFOeW/C+5XlBThL2EIySkOokDiB
	 3e46zWAq8OYdwC9URU18DTDrq2QVY+0Eyy0ldIVJhJilnkdSjyNoayU+kJMW/F+bao
	 beI882/ZtHiMg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 04 May 2024 16:27:57 +0200
X-ME-IP: 86.243.17.157
Message-ID: <38193848-597d-47c1-9aea-5357e58f9983@wanadoo.fr>
Date: Sat, 4 May 2024 16:27:53 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] dmaengine: Add STM32 DMA3 support
To: amelie.delaunay@foss.st.com
Cc: alexandre.torgue@foss.st.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 robh+dt@kernel.org, vkoul@kernel.org
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-6-amelie.delaunay@foss.st.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240423123302.1550592-6-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/04/2024 à 14:32, Amelie Delaunay a écrit :
> STM32 DMA3 driver supports the 3 hardware configurations of the STM32 DMA3
> controller:
> - LPDMA (Low Power): 4 channels, no FIFO
> - GPDMA (General Purpose): 16 channels, FIFO from 8 to 32 bytes
> - HPDMA (High Performance): 16 channels, FIFO from 8 to 256 bytes
> Hardware configuration of the channels is retrieved from the hardware
> configuration registers.
> The client can specify its channel requirements through device tree.
> STM32 DMA3 channels can be individually reserved either because they are
> secure, or dedicated to another CPU.
> Indeed, channels availability depends on Resource Isolation Framework
> (RIF) configuration. RIF grants access to buses with Compartiment ID
> (CIF) filtering, secure and privilege level. It also assigns DMA channels
> to one or several processors.
> DMA channels used by Linux should be CID-filtered and statically assigned
> to CID1 or shared with other CPUs but using semaphore. In case CID
> filtering is not configured, dma-channel-mask property can be used to
> specify available DMA channels to the kernel, otherwise such channels
> will be marked as reserved and can't be used by Linux.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay-rj0Iel/JR4NBDgjK7y7TUQ@public.gmane.org>
> ---

...

> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_put(&pdev->dev);
> +
> +	dev_info(&pdev->dev, "STM32 DMA3 registered rev:%lu.%lu\n",
> +		 FIELD_GET(VERR_MAJREV, verr), FIELD_GET(VERR_MINREV, verr));
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(ddata->clk);
> +
> +	return ret;
> +}
> +
> +static void stm32_dma3_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);

Hi,

missing clk_disable_unprepare(ddata->clk);?

as in the error handling path on the probe just above?

CJ

> +}

...


