Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF51318B3A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBKMyA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 07:54:00 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39853 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhBKMva (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 07:51:30 -0500
Received: by mail-wm1-f47.google.com with SMTP id u14so5623877wmq.4;
        Thu, 11 Feb 2021 04:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1w9Gel/BDEgF0HYKw28X9TdpiF9WT8pY5DoSNZYjXzA=;
        b=AUt8Ob/dpHa/bjRSevIKH7aBTdl1k4KB4za4S3bNfeLkQ5385/NywQP12d+9aSaupA
         8zgIpNkkUP42MjzU+tBz97cFXED0YmI0icaq/yHReMeMYnIS+B99z5qir3bqqeEL3R62
         q4MGLfpu5wzDM7niAfZ8FAPc+UAIgsC2n74i4r/pPieZVjVN/J2OfLjn89PZDHm/w2Z+
         YTvgSRwYIJnBWJY/hMUQX8tLMaTxl3LScqGfzFPvNK4Xxwx8zJEbqERgk7QAMPHn7q0t
         7VP6gAq0Uo3+hTSdf7b6yq+LNO7ug1k0iQsWz3PLzcLcTMqIhTGwIaPjrjJihcYe9iab
         YNLA==
X-Gm-Message-State: AOAM532NOnDIZMffhAOCF4hENyA00y7nK2Ih3/t1RK87SXSb1jxSSCrJ
        JnJcOzT4LeQ1Xzdc+GY675g=
X-Google-Smtp-Source: ABdhPJzuGv6MDsymKFmAJXVoINRB9Wz1HODA1moVdXNW9P7qY3SoA1Ngmv9AyQ2pFkClNPaqCdbCkg==
X-Received: by 2002:a1c:2783:: with SMTP id n125mr4985553wmn.74.1613047848403;
        Thu, 11 Feb 2021 04:50:48 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n10sm4947026wro.39.2021.02.11.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:50:47 -0800 (PST)
Date:   Thu, 11 Feb 2021 13:50:46 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <YCUoJuK8TBsJAnp7@rocinante>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
 <45b51292876f238afe3f6865113cd9d72d33e51a.1613034728.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45b51292876f238afe3f6865113cd9d72d33e51a.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

[...]
> + * Typically this function will be called by the pci driver, which passes

It would be "PCI" here.

> + * through argument the 'struct pci_dev *' already pointing for the device
> + * config space that is associated with the vendor and device ID which will
> + * know which ID to search and what to do with it, however, it might be

Probably "there might be".

> + * cases that this function could be called outside of this scope and
> + * therefore is the caller responsibility to check the vendor and/or
[...]

A suggestion.  This commit message is a little hard to read and could be
improved.

It might just be me (by and large, and I am not a native English
speaker), but it's actually easier to figure out what the function does
after reading the implementation that from the comment. :)

Krzysztof
