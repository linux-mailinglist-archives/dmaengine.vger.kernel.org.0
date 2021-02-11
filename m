Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B76318BCB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhBKNRR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 08:17:17 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45830 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhBKNPO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 08:15:14 -0500
Received: by mail-wr1-f48.google.com with SMTP id m13so4089441wro.12;
        Thu, 11 Feb 2021 05:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ycMXfkQ9Jc89gzim5fZFxu3CgknB7A6guNx/IqyXMFI=;
        b=VsLNPlt7D4Omky93CvoTjjoEqG39mmRsfl7SdaN5IfGeIOGKCQ28Ez1kptTcnC90+x
         9svmSWdfVOoyz++fBoXVoUgfT6crR7WzyoC8ZvpR7PWhesqjpg/aUpBvQ3h6kkU9jDPN
         PORU4ke6gQs0p/JZsRtvlnEBDrDReXzIauK4Vh6ycx+NAc3mxIqomO2p6JW1aw0N7jGh
         uTDfXd1OWzK9tAZG29S5Hz9HoCVb5X5b8tbrFgExcYdp285WtaTolvrWBnnXHBdIcJag
         ZxeylxhNYDLL4n/qRCnAQQULudy7lpPMmFSltaZKUaqFTtS573ZPc7pmQrbhnsZbs5Yi
         QIOw==
X-Gm-Message-State: AOAM530qKjl6cuSpXp5EaFKMOlPy8lfbcMS+Wq0zZTZx4OzMvZkgndw7
        3kxxN3towM3HQjVcxTBdiAkQsRHRhKcx+96m
X-Google-Smtp-Source: ABdhPJxeRGy8LZ1ZaPGyR26mdS/XsTTmjsAot1H0sQ1bpmEaf5cNkAjl3FAB2bni5PK5KAODQqaubg==
X-Received: by 2002:a5d:654f:: with SMTP id z15mr5707567wrv.46.1613049271432;
        Thu, 11 Feb 2021 05:14:31 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v15sm5801098wra.61.2021.02.11.05.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:14:31 -0800 (PST)
Date:   Thu, 11 Feb 2021 14:14:30 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 15/15] dmaengine: dw-edma: Add pcim_iomap_table return
 check
Message-ID: <YCUttpHeRK7trjBr@rocinante>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
 <9deab3ffcc179c4bddd84459ed2a472ca73019fb.1613034728.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9deab3ffcc179c4bddd84459ed2a472ca73019fb.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

> Detected by CoverityScan CID 16555 ("Dereference null return")
[...]

We can use the "Addresses-Coverity:" here, as it seems to become
a canonical thing for Coverity reports.  It would also be nice to
briefly mention what the issues was, if possible.

Krzysztof
