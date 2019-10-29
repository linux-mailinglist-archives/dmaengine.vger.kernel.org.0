Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1CE8DD1
	for <lists+dmaengine@lfdr.de>; Tue, 29 Oct 2019 18:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390690AbfJ2ROj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Oct 2019 13:14:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34022 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfJ2ROj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Oct 2019 13:14:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id l202so1597814oig.1;
        Tue, 29 Oct 2019 10:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7JUjuo8MKJ48oDKK5LQl0/BNKkMnIjG176UmZKTITU4=;
        b=D1aGMnn8uwAKMWQ4ek6gD5GsR328gnWmakOfXugM6nDc4QOSrzskWON5TnQkWkVceq
         GPQsFvqMuOx/KmAv8jXK56Hz0nRlPXJD9jK/v/9j/Ko1+qga/q3XTZ1CGkDDSQv+Jxwu
         PwkfDDcQoawXnwiqRtpFuqfFDa5D2wDDvtkdcEquW4Gu/ORA1gzMzylCnCdG59sl25tM
         PGSyQFS+KqXledh95YPt2HANcd9eqn+00ldqL4KIVI63wapF9k8lmd6ulmlywmVeUZA4
         5TJLwrvBDPRoNXE0DbIcRaEXPYsC4kNE95o009X/cJALgEEL3vOnTXoJ5/o47HgoBuII
         u2GQ==
X-Gm-Message-State: APjAAAW/ODKkDcSgyim126szd7/pDtR1G6gy0J9cw3h4EwSDh3J0DhQc
        KPifmUUAxrU8bEG/HRguLA==
X-Google-Smtp-Source: APXvYqyTyoSyehPOMTSVm7bg+g9+/Xdo3u7RCq/ZLt+3NQ0dc4Rd03BcbXmARRlX/bknzPz1daJ00w==
X-Received: by 2002:a54:460f:: with SMTP id p15mr4665498oip.160.1572369277979;
        Tue, 29 Oct 2019 10:14:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f5sm1408688otf.23.2019.10.29.10.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:14:36 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:14:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH -next 3/6] dt-bindings: dmaengine: xilinx_dma: Add
 binding for Xilinx MCDMA IP
Message-ID: <20191029171435.GA1797@bogus>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1571763622-29281-4-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571763622-29281-4-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 22 Oct 2019 22:30:19 +0530, Radhey Shyam Pandey wrote:
> Add devicetree binding for Xilinx AXI Multichannel Direct Memory Access
> (AXI MCDMA) IP. The AXI MCDMA provides high-bandwidth direct memory
> access between memory and AXI4-Stream target peripherals. The AXI MCDMA
> core provides a scatter-gather interface with multiple channel support
> with independent configuration.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Keep compatible string one per line. Suggested by Rob.
> Reuse the existing xlnx,axi-dma-* channel names. Suggested by Rob.
> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt         | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
