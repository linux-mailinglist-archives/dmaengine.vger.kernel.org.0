Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1528A1E709F
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 01:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437550AbgE1Xp4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 19:45:56 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43324 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437534AbgE1Xpz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 19:45:55 -0400
Received: by mail-il1-f196.google.com with SMTP id l20so702892ilj.10;
        Thu, 28 May 2020 16:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pcctty1/mJG0D0P97qvbV8HHvjEmqkj6IQ/6jBMOQjs=;
        b=i+jWT3YmRJeRhuFR2/KYgQXf5C7flvRXkuOmVjfk8GcqUiQHXfO0FdCblGXD+lXm64
         /ZjKiIg0NDRalXc/caMrgmsBnvYWzeSgybBhS/G0XSrdh6je8OLA7GzHHMRqTUUJZ0nt
         aY2Ch8yp4WFMS/2LBohBrepgqbKhCwSMj9YWwDlQ0rTsRYGQnN1SY3C8D8Xjwhs9kNUu
         dIirSk2AwTqVXXbE0iLO2R0F5Iyq2JNS1nJCykQ3Q1iKM2g/ifuW6ZCNNFH6fCj4+HEc
         eZUz9eiDdZDv/6nzJd3LkAXcJzEsqPPSmNGfjss9LGxTeAs+LgyHNUq9McQ1HLEHuG2F
         wVgg==
X-Gm-Message-State: AOAM532kwF3decNPEd2OG3W9QqXEyvteUhEtZjKiZg02QHdljQfOuCf6
        kmDRBOHTbn8jswfdOtYV3Q==
X-Google-Smtp-Source: ABdhPJzdlt9kxFBLd9U0vhQHkgQPYyhPVlGkuZr2vW60/JIip1IrAy8lX97R1ARnv0AQkrF2N3MLfA==
X-Received: by 2002:a05:6e02:f4e:: with SMTP id y14mr5154401ilj.165.1590709554733;
        Thu, 28 May 2020 16:45:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r17sm4044499ilc.33.2020.05.28.16.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:45:53 -0700 (PDT)
Received: (nullmailer pid 907587 invoked by uid 1000);
        Thu, 28 May 2020 23:45:52 -0000
Date:   Thu, 28 May 2020 17:45:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/8] dt-bindings: dmaengine: renesas,usb-dmac: Add
 binding for r8a7742
Message-ID: <20200528234552.GA906484@bogus>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 24 May 2020 22:37:53 +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Doesn't apply to my tree, so

Acked-by: Rob Herring <robh@kernel.org>
