Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF499318BBE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhBKNOH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 08:14:07 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51705 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhBKNKj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 08:10:39 -0500
Received: by mail-wm1-f48.google.com with SMTP id u16so1851320wmq.1;
        Thu, 11 Feb 2021 05:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmGybuFLlk1Wpc33Qst1livK1cDYSR3qAv6zqONL8yg=;
        b=TRV7NlX1qdPlEnxFLZTqTz+BIiL4K9qIn/yYdaNl4dW46VRoMF09kHJo8uiVhxWbii
         lNk2GWgXKT39Em0xyXD2EOOYNm56hef/tgRHVbB0FPv0uMkMQYJ4MZGFQRfM8OibNvjp
         7sG2DcMmjbT876oZO3HQ6HM/fP0Jj2uWtRoozn4hm6iska5h6Eb3VKdM27V06GItKmHz
         4PBDNsm1YqSsusKwcGLrF8IyFUAI1ezEE30Qj//7WicIT7UjVliDKLOmiW9unhWQ6ncM
         3YzXhdxSlM0DF9OmRYW6hsNprg6H9bzIgT4b+AOn+U4pKqcY/Sm6FGrMtONYbjnM3m6W
         f/Dw==
X-Gm-Message-State: AOAM531uA6bvM+sKf5WlZnLog/6VV1CBkZ8I1WcdloD5EYLvfUDDK1yw
        0XorIgoP1bfyXWcLWWYH588=
X-Google-Smtp-Source: ABdhPJyegMfh7bSSFX1KYjA8E+VlXHxn+7KPzNAOAqfaNlhL36KEkNzMugjzF87288iEebF9zMe1Vw==
X-Received: by 2002:a1c:2d8a:: with SMTP id t132mr4951070wmt.119.1613048996647;
        Thu, 11 Feb 2021 05:09:56 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w15sm4636196wrp.15.2021.02.11.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:09:56 -0800 (PST)
Date:   Thu, 11 Feb 2021 14:09:55 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 14/15] dmaengine: dw-edma: Revert fix scatter-gather
 address calculation
Message-ID: <YCUso1uiuclpIKh1@rocinante>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
 <d936e828ff186d7f4cb6a75ca7a38a91a1f4fd46.1613034728.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d936e828ff186d7f4cb6a75ca7a38a91a1f4fd46.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

> Reverting the applied patch because it caused a regression on
> ARC700 platform (32 bits).
[...]

Do you have the previous commit handy to reference here?

Krzysztof
