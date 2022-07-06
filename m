Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85B0567DD5
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiGFFXz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGFFXk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2DF38BB;
        Tue,  5 Jul 2022 22:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3953661B87;
        Wed,  6 Jul 2022 05:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CC9C3411C;
        Wed,  6 Jul 2022 05:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657085018;
        bh=9AtzBdK2V+n/R6hOfCirne6FJ79S5v8/uOCP5JPibys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poP+4EP4wr6uvWTn/h9bksubpB4Lz0QuRuw/v+hwGzF1wDzGyoBLqo9q7eqEsQN6D
         wU68yTb/iFFWEz7dROJiwoAADRwTOMzGNXKYIeawHwBwGpywWTbPpQl1ZkC79fPjfD
         0HdjdevBCImiBeYmCp5zzlczT4FqkyzuV6oUB8VpT+xlwnIWi3A7Dyk4fF55jN5XYA
         oNUc8q4GTMsBe0Hc/ez8VzHfuB3wqqhRyCOq5oaCmjwB5KvyiVn3wZm/MiQzdokBXr
         R9q/2H3mKEZP/Y0HRfEveouCx1KE8vsAEZ2cOLfjsyjoyONXnVjTq9b+5zYaklPQ8T
         jao/MRQiacH5A==
Date:   Wed, 6 Jul 2022 10:53:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: lgm: Fix an error handling path in
 intel_ldma_probe()
Message-ID: <YsUcVXhGvLVb7VOa@matsya>
References: <18504549bc4d2b62a72a02cb22a2e4d8e6a58720.1653241224.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18504549bc4d2b62a72a02cb22a2e4d8e6a58720.1653241224.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-05-22, 19:41, Christophe JAILLET wrote:
> ldma_clk_disable() calls both:
> 	clk_disable_unprepare(d->core_clk);
> 	reset_control_assert(d->rst);
> 
> So, should devm_reset_control_get_optional() fail, core_clk should not
> be prepare_enable'd before it, otherwise it will never be
> disable_unprepare'd.
> 
> Reorder the code to handle the error handling path as expected.

Applied, thanks

-- 
~Vinod
