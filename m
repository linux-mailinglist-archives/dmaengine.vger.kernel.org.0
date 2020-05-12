Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF21D01BC
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 00:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgELWRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 18:17:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45138 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgELWRe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 18:17:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id e20so11850260otk.12;
        Tue, 12 May 2020 15:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrQ851hnunrgTqto6+wIGdOsYmYlqTuTWO4ADOavgjQ=;
        b=bqr2Jv4gDlam72irY4ekm0BowPQHXAOVJsr+NE3tN7Zc95TUuuIhWoLPAk0dc4XBsH
         75/d4f31rwvoWzUFOQPF9eVFh+O10WhZqttFDh27Fen8DrrR/T0VrHfmPxmKuJ4hWLsP
         SrQ9/N0OxYilKHEQj0DLBHLy7XIrhL1reUANXqRcmGaDkOVJgMSUYR0xrr+6LNBAXCsi
         8WAswiDZcK9q9/CcfdX1mEhhBudtdWxBeHlCtbY44lLGXOUJMOUR2Q/YCJLZGH5kNan+
         GcBV2OB3AOh0iIM0I8NQEDKN1DSItzguKR3//ULRx9r4siKZ9ALkBlGJzQZivesiFeQM
         dMBw==
X-Gm-Message-State: AGi0PuZ9jn1XXUMr7r2pOcKKWBNHs9QlgJpfoynLhD1w3yk/ILHNDPCX
        T8L8tre6QFx0Z15/6ZzM6A==
X-Google-Smtp-Source: APiQypK+0HPJSRVk7oY5OGHm2Knyk+zbvGQGlsq2M4ejPQuqlB3/puDbsR9Qg1uci4g29yQQUydSlg==
X-Received: by 2002:a05:6830:1302:: with SMTP id p2mr18665519otq.183.1589321852427;
        Tue, 12 May 2020 15:17:32 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w73sm5598138oie.34.2020.05.12.15.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:17:31 -0700 (PDT)
Received: (nullmailer pid 2344 invoked by uid 1000);
        Tue, 12 May 2020 22:17:30 -0000
Date:   Tue, 12 May 2020 17:17:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: pinctrl: sh-pfc: Document r8a7742
 PFC support
Message-ID: <20200512221730.GA2213@bogus>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588542414-14826-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun,  3 May 2020 22:46:45 +0100, Lad Prabhakar wrote:
> Document PFC support for the RZ/G1H (R8A7742) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
