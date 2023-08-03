Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4476E9DD
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjHCNSP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjHCNRu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 09:17:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F92719;
        Thu,  3 Aug 2023 06:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D163D61D98;
        Thu,  3 Aug 2023 13:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4A8C433C8;
        Thu,  3 Aug 2023 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068649;
        bh=6PRPkDudfP1aEb4bKDUe/x99OJYIcfxGpunklsGDpLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUsH2/HO6eo5CoSxQVMIvJ7lIfqqRgu3aMRM8leYPmLXh+VxM9ncWawHruXvQi3c7
         KHWb4K1NAEboY0IQpxh5KqUI13AC13ssl81bCPJ/F7C+UNkFBo9o1KZfiP1+J207h6
         KVkjGgw66EjexfvrV9TWZ3avD3rWwTFuKnxofXNsSt/yrK+ffYsPu+L0Ud9uJvUTj4
         Lq5e2lhJwc5a13J7L0/h7nij2Waglx5mpxqPX2JsBmec5sRPtAZCPDJQ/z2ysskWOb
         WztD32864Dwzp5ilHGgmgqx+54vltBCgKfybKuautRZBCT1Pj3l+DeK6B6T795Az5E
         RfZhdWQCV2O8Q==
Date:   Thu, 3 Aug 2023 18:47:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 05/14] dmaengine: idxd: Export wq resource management
 functions
Message-ID: <ZMuo5eNJgKmBog6p@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-6-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-6-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-23, 16:29, Tom Zanussi wrote:
> To allow idxd sub-drivers to access the wq resource management
> functions, export them.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
