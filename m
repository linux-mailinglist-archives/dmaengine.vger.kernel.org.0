Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8C318B67
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 14:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhBKNDM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 08:03:12 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34941 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhBKNAd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 08:00:33 -0500
Received: by mail-wm1-f43.google.com with SMTP id n10so3781045wmq.0;
        Thu, 11 Feb 2021 05:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tUpWYsc5jdodYaLWtSE9NnDVepwL7jind+IhCH0cN9M=;
        b=RBrVsHnPsxUbildIkoEKUUTxlJycJfEVko8JMM/qndPDoTczYu/g/vmGHAI2wVWWZX
         XEHNXfnHFyzvRLtiClPkbsavaDGgFZVOGw0HSKdsKCpDpb4NbAx964fGFkGYkMFQQdWv
         W73Kp9WGEPtj2aTOS8ia4Yl4X7GDUYirgJXSP5mRqQYjOJlxvoGPsdNPkxkgvyAbjOwb
         pw9H2cuARBguqj5lhI2WzGAXMLDdgiheTOTfIRMung4kb/QNDW5G9LGG7eBmuySDh6Oq
         ZpQQaPqhNfmi6bEl5w/mkw9RC8eLUgrs/8e2UodMlrHfsn32fb/+jK9djcPsg++WTIx9
         5Snw==
X-Gm-Message-State: AOAM531jRSUy0DjGoJ8kPOB9WE+tOZTBGVcaRgnNod+V2RCjcO+bSu3i
        eT5UKFrF0jXQrLhh6aibHKw=
X-Google-Smtp-Source: ABdhPJwvwZCNzdFQJSLLk7Tks9nMvG6jkf6nAJ3vPcakCyGjpFE6iO9YmFLK/h7AXd+S0/zx3Dls7Q==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr5230099wmb.78.1613048390462;
        Thu, 11 Feb 2021 04:59:50 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 17sm9888576wmf.32.2021.02.11.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:59:50 -0800 (PST)
Date:   Thu, 11 Feb 2021 13:59:48 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 05/15] dmaengine: dw-edma: Add PCIe VSEC data
 retrieval support
Message-ID: <YCUqRCw1QQD8wa//@rocinante>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
 <6fe327ce082c450e8494b0a1216eb2c8aa82fa98.1613034728.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fe327ce082c450e8494b0a1216eb2c8aa82fa98.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

> +	/*
> +	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
> +	 * for the DMA, if exists one, then reconfigures with the new data
[...]

What about "if one exists" and "then reconfigures it".  Missing period
at the end of the sentence.

Krzysztof
