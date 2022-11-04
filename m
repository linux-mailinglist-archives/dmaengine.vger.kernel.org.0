Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787261991D
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKDOPw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKDOPe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:15:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781F303DA;
        Fri,  4 Nov 2022 07:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56BB8B82D46;
        Fri,  4 Nov 2022 14:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A5C433D6;
        Fri,  4 Nov 2022 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667571288;
        bh=M76OD23L2WG5w30SCSUqpHSoKFgD/vS65QQ7a+OIFwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9V+CibNTCdChu5oMyB3VFgd4eciYli0Jksqo44RN+ELjvnzZP+8pRG4tel/ZHeE/
         +NSIl5aR3VogZLyWXw4N5tw+T5bXxdTNZCu3xClRQIln3kmnm2wIADGkvzJaKX7HSw
         tydcnkoHlhFkyWEZYQ/naNDUJrHyW+Aj/aJzu4KgSBDKZKJN8ckGl5nE++Nrz2N067
         Nzxjz77jzE60seurR512feILW5XF/S1lF0U9zeRZitQ10aTMHqVYof9X46CfdrgfFG
         vJT8r3fMSWKyTajlv0TLBP6xF3CiNqXb4a3KCuBoOuW5RiTEmCa5SmGX5HJmeQ/jEz
         GuQ20kKD0ULYA==
Date:   Fri, 4 Nov 2022 19:44:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 14/21] dmaengine: remove s3c24xx driver
Message-ID: <Y2UeVG8bh+F1rDg+@matsya>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-14-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-14-arnd@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-10-22, 22:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform was removed and this driver is no longer
> needed.

Applied, thanks

-- 
~Vinod
