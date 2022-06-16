Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA7D54E2CE
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377397AbiFPOAr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377456AbiFPOAo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6815F1117D;
        Thu, 16 Jun 2022 07:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03E4961D1C;
        Thu, 16 Jun 2022 14:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D194C34114;
        Thu, 16 Jun 2022 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655388043;
        bh=pKgQ77f7AWoe2hHXLYJ53r5cbt+P7h1gE3OFfrvcHWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmsqnIA/2brT0/MV1yKq7bDBTYUlh8sqkw6sE5iUqQdZTaF1HEgnnMWDzKeZ4CrXG
         XNAjlyfCiJdvjvUh+SlWhp6fNARA3rfpw2lbNQJxYSXD1vaUdF5k+xaqxtdAbPnADo
         5pMdH2ZSt0zXnoRDQmO32Dbihl8g9Fv4RyxZKb8mItBBJ4nxrkOkJIFPkkq0y4zHzf
         0pBOOF+wcRL95h9UhYzym744AvbpiskjhTI2JsXJ/FKQEOFdgO++tPxYR6tOa0UXvZ
         iSdmmLPRdZ/efgaNhF6sX9hedcbMkSPLKgZSEQ7ifZrhnwibb2dBcrEW6AxBOAm7Et
         6GI/jl5uLSXqw==
Date:   Thu, 16 Jun 2022 07:00:42 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/dma to DMA GENERIC
 OFFLOAD ENGINE SUBSYSTEM
Message-ID: <Yqs3ikEB+ZYWyv1c@matsya>
References: <20220613110326.18126-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613110326.18126-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-06-22, 13:03, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/dma
> are also the maintainers of the corresponding directory
> include/dt-bindings/dma.
> 
> Add the file entry for include/dt-bindings/dma to the appropriate
> section in MAINTAINERS.

Applied, thanks

-- 
~Vinod
