Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3437A6BEFF7
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCQRmP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCQRmO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:42:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292543668B;
        Fri, 17 Mar 2023 10:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DD37B8265C;
        Fri, 17 Mar 2023 17:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D9BC433EF;
        Fri, 17 Mar 2023 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074913;
        bh=anvfaypbEl0WSicEpxRSlBGKnQETGwVnCmHpuO+zadY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvnD0TqIazfl438CR4WAQ/lSTlC7A1Il7HMeMm08EfTy8/073Q50eP9i7K/nhAWwX
         KsXctTwEC9UV7xBEWdX2heIuHssmZRXbFAllmBi3ULV7z7t3p31DPIoo3LY8wdM3qg
         9BfT/vPPMaZdsoCykpmtPViUSLQcDdKs98/PKrIbH/Jkx8G0JXJPsNMiO4wW24KUli
         dCCCnUWQheOIHBeW/hTDfEk68Fdqf3FwvOpfrTaQaYSXf0zAnZxzjMlQ73wGvtRbhZ
         0jOm31RUw7F+flovSn2fvhL8Cy7Aofuu0Xvr7eZ+vZn6RdPv+fwPHCq2ZFLDsW9Yzq
         H3odOlVgtRK7g==
Date:   Fri, 17 Mar 2023 23:11:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Use of_property_present() for testing DT
 property presence
Message-ID: <ZBSmXSEMo9g/Y4Kr@matsya>
References: <20230310144704.1541976-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144704.1541976-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-03-23, 08:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.

Applied, thanks

-- 
~Vinod
