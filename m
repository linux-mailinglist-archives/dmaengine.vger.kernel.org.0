Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2649641846
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 00:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407103AbfFKWfM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 18:35:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45824 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405174AbfFKWfM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jun 2019 18:35:12 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so11296069ioc.12;
        Tue, 11 Jun 2019 15:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NCgQwxsu0f3r4btRqej5pZhVli0wu2GBc0gKWgavRis=;
        b=Nn7j2RkQ7LwCq7tRGrwPzOkfh0I79XGw9slQaYNAoRVNjaJLdJs7IQakHEU8aZJDgl
         ORN60sXcuYxeQIbcvccw899YbDkzhQWTBykmehNWCSL5IGislKAlVPR8aMDHdoSWfhGA
         U747IGH1l95gR5x+yC+rMVKqoSoV3X04B9jKiZB9PwL8vTpuU8khEpnC7WBc7wn7O3UW
         dSG/McsLdIqowtlbv8pXXyoAgapRGz/LrMYWJIVQU/2QMzc9QMay7lRANnQD5tIO5yNb
         y21qyzxwqbWLs0es9LmGgQX6N78wTpHBGd30Jw887uoXBBYGQWvsY4a3m5XxLGic5tgk
         AFgw==
X-Gm-Message-State: APjAAAVTYrVM2i5Jfc7ljuocImzytGE5XP34gK5tLfXW/EE+8U0CQy7w
        R2YH3n9jTEGQSkOxeP43Fw==
X-Google-Smtp-Source: APXvYqyldbzjVVfHCAHQd21SudrsdTqB9IH5YfFTe83h4l7n3V0qepl2ZRh+aD/yH4IiOo6MWE21IQ==
X-Received: by 2002:a05:6602:2256:: with SMTP id o22mr19307948ioo.95.1560292511617;
        Tue, 11 Jun 2019 15:35:11 -0700 (PDT)
Received: from localhost (ip-174-149-252-64.englco.spcsdns.net. [174.149.252.64])
        by smtp.gmail.com with ESMTPSA id q142sm1884761itb.17.2019.06.11.15.35.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 15:35:10 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:35:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, broonie@kernel.org,
        festevam@gmail.com, vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/15] dma: imx-sdma: add i.mx6ul/6sx compatible name
Message-ID: <20190611223507.GA25722@bogus>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-11-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-11-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 10 Jun 2019 16:17:48 +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Add i.mx6ul and i.mx6sx compatible name in binding doc.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
