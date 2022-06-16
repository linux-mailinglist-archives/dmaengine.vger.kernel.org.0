Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3D454EC1D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378935AbiFPVIA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378976AbiFPVHy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 17:07:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF5F13F64
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 14:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2229DB825E4
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 21:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67DBC34114;
        Thu, 16 Jun 2022 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655413669;
        bh=iSdbMmS2bLfSP9svTf2fZlkH7JkK+XFgaaD2B26EKqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmBLTiAokbZHybRPkB79+cGTv7Q2XWIY7rj2jkihjgOc1/RP2hLREuOeJFN/A8DgE
         4Jcn7Psa/zyqzkgd9WPO4j1D4/HLI/zR8L5XxLHOWHf5wRBN5OX2z/LdtFKCQcSd65
         KZZLHkNKa0ViKttBOP3wJY7YSR3xGmumOS0ezolJzGvocyZcjtYSMgLLUx9X8Sj+dr
         7mJwfSoONWg0Oeag6ABJipUGa0vTQ0QIRnjm52ZsVItwrPWfDtatWxrOttJOcKbZZk
         NihmmEAxM4gO6T9v5sbYvPCHfUDE8NpgT9D8VcKXHtPSpeTD/vBdXxc38r5BdOu1KS
         LSGgNa9dLKQ3g==
Date:   Thu, 16 Jun 2022 14:07:49 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: idxd driver maintainer update
Message-ID: <YqubpRICTCg43aWg@matsya>
References: <20220615232651.177098-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615232651.177098-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-22, 16:26, Fenghua Yu wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Add Fenghua as maintainer of the idxd driver.

Applied, thanks

-- 
~Vinod
