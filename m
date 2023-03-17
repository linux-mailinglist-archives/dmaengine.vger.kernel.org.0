Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5B6BEF73
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCQRTK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCQRTJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:19:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD935AE;
        Fri, 17 Mar 2023 10:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A2D7B82640;
        Fri, 17 Mar 2023 17:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27763C433EF;
        Fri, 17 Mar 2023 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679073545;
        bh=utvmjvDg99qFrau/gAOJfjUukmOIEn88M1vi6ZEIoAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXZkspCWybNiYgqViRvc1gYmN4KQewKLs6sCN8bn42dNltUFjzxxMihVxOhqUTceE
         Ka5bb9olhBvXIgBb1YHe49ZlbbAIdvXdzpJ3RQuR32tv5ywIBpRgey/EUmIJuBuBmx
         uXfH7TxgaBJ1eWCsmaEFWJQoaAMvlwj++xCN/EJj6Mz6n4esvVCvB1HL/htC5Vieyt
         C+F/zqi+rYC0f4bAdXBTW9eHGwatLIU/WL/4dGHmixtq2GxTq+970mpgJrf341WJD8
         TAAKtCj7axZsZqQzkljLByo0EXm0yvfR6Kawn5sgjzYRrSFSmtjjOmr9P4G6THwbG6
         Yms/UHu7k0Y7A==
Date:   Fri, 17 Mar 2023 22:49:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 32/36] dmaengine: idxd: use const struct bus_type *
Message-ID: <ZBShBIhPxfV1uOyf@matsya>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-32-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-32-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-03-23, 19:29, Greg Kroah-Hartman wrote:
> In the functions unbind_store() and bind_store(), a struct bus_type *
> should be a const one, as the driver core bus functions used by this
> variable are expecting the pointer to be constant, and these functions
> do not modify the pointer at all.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
