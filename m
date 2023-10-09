Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845287BD311
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjJIGMP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A119E;
        Sun,  8 Oct 2023 23:12:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714CBC433C8;
        Mon,  9 Oct 2023 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831933;
        bh=VVc6hDifgti0ubiSRz34eNWT2uN4aWAM0vQKyzQ7xq4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HawuaW4atxpP3DrS/dnw/sstX3KxXHMl/F2kZ4tb8o7UgJGWTAe3Pha2yjX8nYK8w
         OrBz/vOMaIPiPm8OvGYamKP9fNLpmBdunuDFlYNpzSyz3lGh5qhBtkusB8xZTqc9+i
         vL3bccKwq0qg7z+sNx0MxWM2aFDAShrVRJ6ov7UKjhonoB2DUBXtFRS4+1SbTUf7WZ
         jSKBRbVSGJ0pgtUXSxligXZUONYWkV8uK+rUNYf0RawQjtOM2gSU7X0JM0MJ8McZI8
         ID3Vg0no+Tcr5XWulomiiP01ETZUPR1WZ8l+JFYmI10FUuRK0p/T8FTp3XT1664nD4
         KU0+9PB4UQcXA==
From:   Vinod Koul <vkoul@kernel.org>
To:     rdunlap@infradead.org, Frank Li <Frank.Li@nxp.com>
Cc:     dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com
In-Reply-To: <20230824145834.2825847-1-Frank.Li@nxp.com>
References: <20230824145834.2825847-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/1] MAINTAINERS: Add entries for NXP(Freescale)
 eDMA drivers
Message-Id: <169683193008.43997.12102895009675453131.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:10 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 24 Aug 2023 10:58:34 -0400, Frank Li wrote:
> Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
      commit: 9f895354cc3cf4fbff21c922a5721691ed40589d

Best regards,
-- 
~Vinod


