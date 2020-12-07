Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5FE2D1DD6
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 23:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgLGW5b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 17:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgLGW5b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 17:57:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400CCC061749;
        Mon,  7 Dec 2020 14:56:45 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so21890442ejj.7;
        Mon, 07 Dec 2020 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zU+qQFKdWZjfJ+RDJwbypYwf59sZH0V4V5cKayroUxc=;
        b=GxaNnbN1FkZTq/Z/73I9lRXWVFnW+6/gYBwPv2syEcdn6WlBBHVR+AoBOIqSLbeYPT
         +3n43Y0mYeHstt4QuLC17iH5/nAo1GLGnZHD4+kG06HCKc8jdhIJ3dW4i1J3IzUq3Hx0
         H5z6Iz9fOwFuuqdePTZfasYetoplTN8ewySisDAHccgaIQJF01ewkzMboZkOjswUrM+U
         vMyoXve7MHdZ11Zk+tVhTwkgNPLbFt+Bi4xm4uEcuKppvmL/xxlgNbVWB5k8Aj1lGtBz
         rCp5rdSTqXI3ZZuNExxDccnQgyTBP8+w51niWEsrdbQiqg7Mv5iH/c0RmvQPxVa2vvAy
         b8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zU+qQFKdWZjfJ+RDJwbypYwf59sZH0V4V5cKayroUxc=;
        b=lHMp6I2htYDU+FRlmlb+S+ollIySY4rU9F7N7oiNvRP4WolOCU07uGzp+HbNawUVNI
         HeBb9xxstB3MhFgLqTOkEtPtIQDT8YGbCdcZHylfhhjbwMPou/rMX/CjphrY4JYd6Pjh
         QamOeywnKcA+5DXAeYD2Pgrt2ShTojmqw0+WSqx6/t7aDz6lqHVcYg8BbPLKvR0wFpaO
         Uqd4ch0xpKk9q039ONFf3uRn5zB6ouDNfwqLqMnhCcx4z0FGNDRCvNRokTj0EOA4SE9z
         kd2Ygd5he331A6WY+dvMwYE/KfXrPWt3xst4qZY+QZJWnQWId8/8PMU1oph6jmPF9x3b
         P4mQ==
X-Gm-Message-State: AOAM531zxuUDriOUmc+8/2APCdMZswNZLUVU9gYQxLyiixxv31CSaNMZ
        /5xCfuuAT69mBziL7qn4xKE=
X-Google-Smtp-Source: ABdhPJyU2elBWQBkZCA9xFi5xpiulFFA1qg9UPLdyBp0aoKvHW1JQnwNR7C0cdx3gNqJgZBYGnBRBg==
X-Received: by 2002:a17:906:c007:: with SMTP id e7mr20495234ejz.511.1607381804031;
        Mon, 07 Dec 2020 14:56:44 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id ca4sm9115038edb.80.2020.12.07.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:56:43 -0800 (PST)
Date:   Tue, 8 Dec 2020 00:56:47 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 04/18] dt-bindings: dma: owl: Add compatible string
 for Actions Semi S500 SoC
Message-ID: <20201207225647.GC250758@ubuntu2004>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <0e79dffdf105ded2bb336ab38dc39b4986667683.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201207221107.GA927276@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207221107.GA927276@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 07, 2020 at 04:11:07PM -0600, Rob Herring wrote:
> On Fri, 20 Nov 2020 01:55:58 +0200, Cristian Ciocaltea wrote:
> > Add a new compatible string corresponding to the DMA controller found
> > in the S500 variant of the Actions Semi Owl SoCs family.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/dma/owl-dma.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for reviewing,
Cristi
