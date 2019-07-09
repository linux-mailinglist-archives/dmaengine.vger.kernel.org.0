Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7A62E05
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2019 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGICRz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jul 2019 22:17:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44333 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICRz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 Jul 2019 22:17:55 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so39781024iob.11;
        Mon, 08 Jul 2019 19:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjoGM7Wxe563lt2QEMzedfEv/oSE8kILweoYwhow1Iw=;
        b=cdYu33aCcEFvOlz9LtCEyc+0YfKwXyeAOHKB6EgmMcLHti1T+juraNUaUMFdLrQO0i
         UqKYLSOmHLSazuKr3QYTQSilsWb+ySrBewj+N+8BBcfrOWbmowluKw3xGbN9I8/fEADL
         Mhbc09P4qSJv5xUrO4etftB6n28IVpudDjrLrwR6q4j8Na3/PBJAc236Hcil7DS0YZtg
         jMZHzn5zAKJRlD1nOUqhr//iIkB0+QSilRHJPW5BzcfUXfoRA3y84oBmCTFPl7x0IWz+
         On7fm6hg2IhU1QLMqpvFoiZ8WyWldA7HwosmHr2G/iKL1r8paiaXOlVqlpMIWVv/Q2W5
         uT3A==
X-Gm-Message-State: APjAAAWgFpq2d+EImPq9s5YmqcUvfsnqF7XwPSkiBxCcQOWCuX9HPSDf
        JRM6wivWCkbXPjRRIa4rkg==
X-Google-Smtp-Source: APXvYqw2MSMSTPDKr0hezGEPUjDdJtsCKqWkhfbqCfu9I/mUn4AvK/Y9H6kSLF5ZreFy1Ml/afZiGg==
X-Received: by 2002:a02:ac09:: with SMTP id a9mr11371164jao.48.1562638674579;
        Mon, 08 Jul 2019 19:17:54 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e26sm16401377iod.10.2019.07.08.19.17.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:17:53 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:17:53 -0600
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
Subject: Re: [PATCH v5 08/15] spi: imx: add new i.mx6ul compatible name in
 binding doc
Message-ID: <20190709021753.GA8533@bogus>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-9-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-9-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 10 Jun 2019 16:17:46 +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> ERR009165 fixed from i.mx6ul, add its compatible name in binding
> doc.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
