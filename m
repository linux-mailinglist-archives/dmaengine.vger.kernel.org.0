Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE14176E70A
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 13:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjHCLgo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjHCLgk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 07:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDB26B6;
        Thu,  3 Aug 2023 04:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EA1C61D50;
        Thu,  3 Aug 2023 11:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE80CC433C7;
        Thu,  3 Aug 2023 11:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062595;
        bh=UjTnzA1uyWax5cLoTVXHxVc24fwORm5eBxW+i5hCwfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZp4FdI5y8YwZwC80GQ37MfdIDxageDzY+c+c7KuikUI9ea28ok8f7BEphllYWal8
         IJ9RH+AhoU+XxgiCmvp9pd9wyXmmIfr5sD08AVlyUCO4zuES5RHfstemqVyH8cTgvi
         6ZA+1Fy/1QPJCjsiDBtjQ+qKrhyMexkeBfwH2KJgP5TpkjBuQRTu3I1I/qYdpMEUr9
         d5n3yc05Aj6v1Ryw0w6glCLvU5r6WLahywP+SiWVcQxIYOtVsz/Xm1AfudEyblYqzO
         db6qWMTJTUVHsJ2geQ6pDvmgF6dKnVJWnXxo7WiVITUAdwuAj5loO352XUS2J97FwP
         XbecLwfXnOO0A==
Date:   Thu, 3 Aug 2023 17:06:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 01/14] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Message-ID: <ZMuRP/LhSxa/Hf4x@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-2-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-2-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-23, 16:29, Tom Zanussi wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> With the possibility of multiple wq drivers that can be bound to the wq,
> the user config tool accel-config needs a way to know which wq driver to
> bind to the wq. Introduce per wq driver_name sysfs attribute where the user
> can indicate the driver to be bound to the wq. This allows accel-config to
> just bind to the driver using wq->driver_name.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
