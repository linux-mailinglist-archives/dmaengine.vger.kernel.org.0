Return-Path: <dmaengine+bounces-890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BE841EB1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70AA7B2F09A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482858108;
	Tue, 30 Jan 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPbgxoi7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C657889
	for <dmaengine@vger.kernel.org>; Tue, 30 Jan 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604844; cv=none; b=s0pMUzf4llqBTna5CSizwQHARKEk3ydW10chqtm9QqJ4FYfPPVNshcL/LYWtu4Tj9XyM/fhXBca6VqWXNHLgmx9hHHOW8IE+PsF+dhRjRynRfzJgQ3/nY2YuLy3KRoYF37DkEJRkFPieTaeGoivj+OP4ZcplLatU/GFzNfOxCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604844; c=relaxed/simple;
	bh=G8sl2lS+IaDiGr/COgYH10cSJ7PzxMwL+ublPA4/gvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXcu10T8FvWuy2JGTmC4MPzIUUOIBNnvrSgXt0KMxOLtLbI4KI5OanxVtendPuwFhVA0MjAhquPIt+/NB3D2PnVCkdYTQjLRUuidWgNVaH6lVGH8+o0DUlOYBmp7gjKgaFBCLzktAjUgZMzm/KDWHlfQARTf7rWdub0nqYrh5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPbgxoi7; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3be5973913bso694172b6e.3
        for <dmaengine@vger.kernel.org>; Tue, 30 Jan 2024 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706604841; x=1707209641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7TkZJIKQyigRSw9xWbiatjiA506UbWDVE+Kdu3nQRyk=;
        b=zPbgxoi7VBa+k0GUe+XCvN0hsM0hVzFoLAmjsJxbtMaxyhUctvawiAnVmUKhoJS4dX
         Dshbet+62X3Yh1/sc2LBjha2eafPw+cu/nIzh2dwLmI6NOtzpo//qwCU52bWct5UAD3E
         j2RNzZ0d2FevjSNz7UwDo7J8VBzegEsbFlkXVvQJvYHDkPNPOITO95ZOeDFkzBOZLOtQ
         weH7GshiJr2zUDyRq3t0qFiYUb+LMs7qWDsgyLWpTegpXpUUDRcLv82Gjpy5FAKczPF3
         nQKFsEdJgydS9JxBDYBr1k5ulSx21XFoAcC55wOzDYzvdicEjVw3i+NHYQWI+cZl3C1u
         PaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604841; x=1707209641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TkZJIKQyigRSw9xWbiatjiA506UbWDVE+Kdu3nQRyk=;
        b=LYWVfDYUWgbQP0Dpycy1eNzz/a8oOBzKFxZZsM+CwycnhOo0eTEKGl/ot6bCGiiBTO
         pmyCzzDEXJGqU9VOSu5BcN07vEJf+Hm8PZh0A/iHL4PT+Ynu8KgPEU5dtWUyzVfL+wsd
         umlEGLhN9Y29OGj4sS2RFfld10M2Orspc5VT+yl7/5OQKWpQx87xPbE/eezkYg5uJMRS
         /aRq/Nl4GnL5sDt98BOawcUrKPG19QK4YJQLc2qOOdHxprNfzN1WV/ApNG3+oo1MWLA0
         hJlV13/Wv7QqJot5wy0C8JxMBmrzKkn5I33+tWGU8o7/cf6N4ifD4dKM7JZUFjdj+H9u
         IQ0A==
X-Gm-Message-State: AOJu0Yzva2J25why59e8GKbGvkXlHbtxU0Gh+HG1iaxqiyz7TqNrumFM
	68lwAIidrKmJ7qPjg7DoA/MxHBwdyxHz4FhsDVDcQPI7D+evf2kNv7KP30OTvw==
X-Google-Smtp-Source: AGHT+IHF8tvqT6/4XZap19WF5cks4KGjl1+krysKoU6uZio3PMGnP7+Hq13PeNnAUYP203TS4jLkEw==
X-Received: by 2002:a05:6808:1287:b0:3bd:f103:4550 with SMTP id a7-20020a056808128700b003bdf1034550mr4853058oiw.34.1706604841479;
        Tue, 30 Jan 2024 00:54:01 -0800 (PST)
Received: from thinkpad ([117.202.188.6])
        by smtp.gmail.com with ESMTPSA id s20-20020a056a00195400b006dbe42b8f75sm7180736pfk.220.2024.01.30.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:54:01 -0800 (PST)
Date: Tue, 30 Jan 2024 14:23:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v1 6/6] PCI: epf-mhi: Add flag to enable HDMA for SA8775P
Message-ID: <20240130085351.GC83288@thinkpad>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-7-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1705669223-5655-7-git-send-email-quic_msarkar@quicinc.com>

On Fri, Jan 19, 2024 at 06:30:22PM +0530, Mrinmay Sarkar wrote:
> SA8775P supports HDMA as DMA engine so adding 'MHI_EPF_USE_DMA'

s/adding/add

> flag to enable HDMA support.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

With above addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 2c54d80..570c1d1f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -137,6 +137,7 @@ static const struct pci_epf_mhi_ep_info sa8775p_info = {
>  	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
>  	.msi_count = 32,
>  	.mru = 0x8000,
> +	.flags = MHI_EPF_USE_DMA,
>  };
>  
>  struct pci_epf_mhi {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

