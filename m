Return-Path: <dmaengine+bounces-8970-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAzPDcPJlmminQIAu9opvQ
	(envelope-from <dmaengine+bounces-8970-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 09:28:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C082715D0F7
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 09:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E828A3004F02
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D9337113;
	Thu, 19 Feb 2026 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y03mdI9t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E957336EC5
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489726; cv=none; b=gm6/LJGhdVYb0OtSxWsP/T4Z5v5IJjGxTXHfUTZbdjWmrlgZtxbNFk2+hYLz2RfdHPOLGThcW76HjbFNsdioBBULq3ya1zsjcfkdWGeiDdxNuUxHztBfn8t4fMQPrCERa/4iRXTthU52p5qr/GkQ+emaIscWCCtsjXsYScvLoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489726; c=relaxed/simple;
	bh=CZdvF0NSmvpT3FQaL3yhFOnbzjIg5pEomEvylH7mBNs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cn/u74kAPA2jwy2924eVqpIRlOKo3lXWh0e8n8FL5C3PjHf9ps+b46jr08f4Rcpfr4HdiFVysGNbDArhG+OeF4cmn1r2fObI0lYEe4s0b9CbmkoF1gVSQfKIZWEYTz1wLOw6UcYt91tjsRvs03Ff/MspUAgxJbADAdMBHMcVzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y03mdI9t; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43622089851so572197f8f.3
        for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 00:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771489723; x=1772094523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LlA0MoNwLthJ3WbFXT1GsIbvdxg0vIHk87hmvUw3AEo=;
        b=Y03mdI9tvY00dYQhfNv5kT2SYD0ADW0aJpU0ED70lX79qO6fKJxENWQ3Gi6cHxd2SN
         WgmmNsIsXrPNDwqTQ1e+00MSBVQe+aet/J0J4ecOXqpjovd+VAR6SaFVmyETM1fNtU5E
         m98kh4fhisGlK/IKd9WMX9jVlPbnoGCv/JdLu6tA1QfmmDICyW/v2CG4q9i9d0nhefE+
         4z31/rgtR5cRLtiv158IBwbRYBM3UxjuUUraJ0eryKu4Dw2921NaLjquNDa+umbXStBl
         QuKSdT78t3nk6bk77J6pqseJdxFAoERgt2mivot2s2/F1DAreEaPA7qqKU5pceQhVMwY
         55Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771489723; x=1772094523;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlA0MoNwLthJ3WbFXT1GsIbvdxg0vIHk87hmvUw3AEo=;
        b=t4q7NbPsHwTCZp6cuU4XvXGTSjPH64nio0LlMoz4iLGWMosAv1845QE95PPXQDjRT6
         jArtyLosBJVVPNwoSXgj2sorCro8RlaUCAI1Dst8J+hwNR5FqeXj1tU+uispnCq+L8Yu
         0qiMETIEo2c3FWvb3wORQkRniqVuzNAkh5BT2QF1yzhrEuIZX3xzchxrAQklgV66x/Dg
         GVQzL+FIjSIXjCGloDxD4NFANBhe955kyS6jLYbYsPek823mt1hNp+sS+VRKufhgJ44l
         XtdfiPkl/lZawoH8jSpKhXo6xi1PwQrUg4PrYHIInGYVcafTrK7KG1dKhhJS7/R6EI2K
         tWNg==
X-Forwarded-Encrypted: i=1; AJvYcCUuuZ4KCgnHwzNTE9B97l+/M2OpfeRTwe+Bn7hDf18M8y4CqUGQuEPRSIuu4Gbjk2SJtlVxH7Jjhk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWO6KbJD8dxla3RAY605FLBVjjrT2iabXgiMBLOxlnDBpr3Rqt
	yh3PZ84LuHKQr0GurVgAjfOgPAd28TGBgzj12UJ+3M/VPhfC4tAWtz1b7NupJVsu1sU=
X-Gm-Gg: AZuq6aIKLKEiIy2McH2yBhakatNv3GOvJAb98dtT+oL9FIvaUna9gGfEPBr0lOy5ioi
	tuBKttTNjIph5bywVeIKG8Z00ljRtVs0dCuJeGad35ApwYqRwtLeMCkRlwv3vOJYgAlW2JwDj6e
	cxOgN+enmhcorAdoHTX/eNPj/OyT7QOKT/B5l8/96R4HGbWgOLzYUcvVvAMVW0XNGAManRl9++X
	7VTpVkYhc3UxdHd2wlHb2qP4/ooGAAFyNNmrgN2pPjWiz8HYUzN16yVQXY++gislc+fSQtEVx0g
	Wi6Xf3i3q+qJHWah/ywBA3gUC9dSk/DMkd1C0DkA0hP6Ng96qDKzQRFxrJ6b4heTotrlzZoGQ5O
	qlRnTuYFHheOmQbjHCCH4MmwaHJe0SpDY1pM5qkXW/+vir+o3M7KYmOek7bEvd011LV6u8GVjjT
	kkkL0qZP2G7BL4qtcdOcss17pFN02C
X-Received: by 2002:a05:6000:402b:b0:437:678b:83c2 with SMTP id ffacd0b85a97d-43958e5794dmr8711741f8f.54.1771489723133;
        Thu, 19 Feb 2026 00:28:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm44982348f8f.7.2026.02.19.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 00:28:42 -0800 (PST)
Date: Thu, 19 Feb 2026 11:28:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Akhil R <akhilrajeev@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de,
	Akhil R <akhilrajeev@nvidia.com>
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <202602181757.Amx49qCP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-7-akhilrajeev@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8970-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,01.org:url,intel.com:mid,intel.com:email,git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C082715D0F7
X-Rspamd-Action: no action

Hi Akhil,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-R/dt-bindings-dma-nvidia-tegra186-gpc-dma-Add-iommu-map-property/20260218-014114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260217173457.18628-7-akhilrajeev%40nvidia.com
patch subject: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
config: sparc64-randconfig-r072-20260218 (https://download.01.org/0day-ci/archive/20260218/202602181757.Amx49qCP-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 10.5.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202602181757.Amx49qCP-lkp@intel.com/

smatch warnings:
drivers/dma/tegra186-gpc-dma.c:1543 tegra_dma_probe() warn: missing error code 'ret'

vim +/ret +1543 drivers/dma/tegra186-gpc-dma.c

ee17028009d49f Akhil R         2022-02-25  1514  	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
ee17028009d49f Akhil R         2022-02-25  1515  
ee17028009d49f Akhil R         2022-02-25  1516  	ret = dma_async_device_register(&tdma->dma_dev);
ee17028009d49f Akhil R         2022-02-25  1517  	if (ret < 0) {
ee17028009d49f Akhil R         2022-02-25  1518  		dev_err_probe(&pdev->dev, ret,
ee17028009d49f Akhil R         2022-02-25  1519  			      "GPC DMA driver registration failed\n");
ee17028009d49f Akhil R         2022-02-25  1520  		return ret;
ee17028009d49f Akhil R         2022-02-25  1521  	}
ee17028009d49f Akhil R         2022-02-25  1522  
43f59d3fa0deca Akhil R         2026-02-17  1523  	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
43f59d3fa0deca Akhil R         2026-02-17  1524  		struct device *chdev = &chan->dev->device;
43f59d3fa0deca Akhil R         2026-02-17  1525  
43f59d3fa0deca Akhil R         2026-02-17  1526  		tdc = to_tegra_dma_chan(chan);
43f59d3fa0deca Akhil R         2026-02-17  1527  		if (use_iommu_map) {
43f59d3fa0deca Akhil R         2026-02-17  1528  			chdev->coherent_dma_mask = pdev->dev.coherent_dma_mask;
43f59d3fa0deca Akhil R         2026-02-17  1529  			chdev->dma_mask = &chdev->coherent_dma_mask;
43f59d3fa0deca Akhil R         2026-02-17  1530  			chdev->bus = pdev->dev.bus;
43f59d3fa0deca Akhil R         2026-02-17  1531  
43f59d3fa0deca Akhil R         2026-02-17  1532  			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
43f59d3fa0deca Akhil R         2026-02-17  1533  						  true, &tdc->id);
43f59d3fa0deca Akhil R         2026-02-17  1534  			if (ret) {
43f59d3fa0deca Akhil R         2026-02-17  1535  				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
43f59d3fa0deca Akhil R         2026-02-17  1536  					tdc->id, ret);
43f59d3fa0deca Akhil R         2026-02-17  1537  				goto err_unregister;
43f59d3fa0deca Akhil R         2026-02-17  1538  			}
43f59d3fa0deca Akhil R         2026-02-17  1539  
43f59d3fa0deca Akhil R         2026-02-17  1540  			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
43f59d3fa0deca Akhil R         2026-02-17  1541  				dev_err(chdev, "Failed to get stream ID for channel %d\n",
43f59d3fa0deca Akhil R         2026-02-17  1542  					tdc->id);
43f59d3fa0deca Akhil R         2026-02-17 @1543  				goto err_unregister;

ret = -EINVAL;

43f59d3fa0deca Akhil R         2026-02-17  1544  			}
43f59d3fa0deca Akhil R         2026-02-17  1545  
43f59d3fa0deca Akhil R         2026-02-17  1546  			chan->dev->chan_dma_dev = true;
43f59d3fa0deca Akhil R         2026-02-17  1547  		}
43f59d3fa0deca Akhil R         2026-02-17  1548  
43f59d3fa0deca Akhil R         2026-02-17  1549  		/* program stream-id for this channel */
43f59d3fa0deca Akhil R         2026-02-17  1550  		tegra_dma_program_sid(tdc, stream_id);
43f59d3fa0deca Akhil R         2026-02-17  1551  		tdc->stream_id = stream_id;
43f59d3fa0deca Akhil R         2026-02-17  1552  	}
43f59d3fa0deca Akhil R         2026-02-17  1553  
ee17028009d49f Akhil R         2022-02-25  1554  	ret = of_dma_controller_register(pdev->dev.of_node,
ee17028009d49f Akhil R         2022-02-25  1555  					 tegra_dma_of_xlate, tdma);
ee17028009d49f Akhil R         2022-02-25  1556  	if (ret < 0) {
ee17028009d49f Akhil R         2022-02-25  1557  		dev_err_probe(&pdev->dev, ret,
ee17028009d49f Akhil R         2022-02-25  1558  			      "GPC DMA OF registration failed\n");
43f59d3fa0deca Akhil R         2026-02-17  1559  		goto err_unregister;
ee17028009d49f Akhil R         2022-02-25  1560  	}
ee17028009d49f Akhil R         2022-02-25  1561  
43f59d3fa0deca Akhil R         2026-02-17  1562  	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
3a0c95b61385f5 Akhil R         2022-11-10  1563  		 hweight_long(tdma->chan_mask));
ee17028009d49f Akhil R         2022-02-25  1564  
ee17028009d49f Akhil R         2022-02-25  1565  	return 0;
43f59d3fa0deca Akhil R         2026-02-17  1566  
43f59d3fa0deca Akhil R         2026-02-17  1567  err_unregister:
43f59d3fa0deca Akhil R         2026-02-17  1568  	dma_async_device_unregister(&tdma->dma_dev);
43f59d3fa0deca Akhil R         2026-02-17  1569  	return ret;
ee17028009d49f Akhil R         2022-02-25  1570  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


