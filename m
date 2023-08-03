Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46676E9ED
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHCNT6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 09:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjHCNT4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 09:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754A21702;
        Thu,  3 Aug 2023 06:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEFC61D85;
        Thu,  3 Aug 2023 13:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1FAC433C8;
        Thu,  3 Aug 2023 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068794;
        bh=QAcdIxPt6Z4jEkbTczIGbySpj2WAo6Wkto4VluXA76o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edvi8/kk+ZerTe/+2V3yhJBEwsZ3NUIzxgrBUgBvn667b0xm3CcHEeKgAOAUaOXnY
         fgbXRNq3M5bQSwG0AM+RxjKMs4fJmDF6WTFIlYQgbG37zKLtNABnI029+iZh5erwDy
         uTA35tRAt4tpaR6NpusrUbQurpXS58Qfk0zrRSNgz6oQiBZp87hRDczumpOJPQX2yg
         25/Xe8Ic2m2SUX8nQdH22gYuMScFOt8jGcz28n4PaE7SLsr3n7U4nsd6bstPBRjUDa
         aEXJKmYu6T0tr4HMwSoGqzYmRDN0SfkNCZF14ihFCGQcMu4RlpYai08AHG3o9HyF1K
         s5YAN4vxDe+yw==
Date:   Thu, 3 Aug 2023 18:49:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 07/14] dmaengine: idxd: add callback support for iaa
 crypto
Message-ID: <ZMupdvn8J+mM2Kak@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-8-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-8-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-23, 16:29, Tom Zanussi wrote:
> Create a lightweight callback interface to allow idxd sub-drivers to
> be notified when work sent to idxd wqs has completed.
> 
> For a sub-driver to be notified of work completion, it needs to:
> 
>   - Set the descriptor's 'Request Completion Interrupt'
>     (IDXD_OP_FLAG_RCI)
> 
>   - Set the sub-driver desc_complete() callback when registering the
>     sub-driver e.g.:
> 
>       struct idxd_device_driver my_drv = {
>             .probe = my_probe,
>             .desc_complete = my_complete,
>       }
> 
>   - Set the sub-driver-specific context in the sub-driver's descriptor
>     e.g:
> 
>       idxd_desc->crypto.req = req;
>       idxd_desc->crypto.tfm = tfm;
>       idxd_desc->crypto.src_addr = src_addr;
>       idxd_desc->crypto.dst_addr = dst_addr;
> 
> When the work completes and the completion irq fires, idxd will invoke
> the desc_complete() callback with pointers to the descriptor, context,
> and completion_type.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
