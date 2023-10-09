Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9F7BD31E
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjJIGMi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbjJIGMe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B8D8;
        Sun,  8 Oct 2023 23:12:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B925FC433CA;
        Mon,  9 Oct 2023 06:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831950;
        bh=dbhhiVSslKuZeTU8xgrFM5xEx8ji9w2nubCjVDsgT/8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NZ6glDo4PNbrCVcImzZsTTHlB2OHRXfg/FCki8VJDEdj7w8YwGaJ17lAbmBZIUNCU
         N4WMQBYsusVs3fDi92W4Z8dA1gvZwBFMlxYGZbAS15rm7QavVjXZHhgvuEefBa2QiV
         HAzFKgmMufeKPM60fjveIHefuna9qEAPY302v3OoMoRepoRrnK02SVeYfq9bRkjyA3
         3X/rNV4QCC9Djm8OP93fYSaAJKO2aVQ21LjduL5nv5VR+CDj8scIC+HVEwm5/DtaUw
         ic9xcYe4a2oP9a1jsouRQcgWrS6Oz/EVoWM6b1qRZ/dVtRFCLQ2nEv81J+ki2tLALN
         VZ+mMtC35w3zA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Frank.li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        joy.zou@nxp.com, linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        rdunlap@infradead.org, shenwei.wang@nxp.com
In-Reply-To: <20231004143228.839288-1-Frank.Li@nxp.com>
References: <20231004143228.839288-1-Frank.Li@nxp.com>
Subject: Re: [PATCH resent 1/1] MAINTAINERS: Add entries for NXP(Freescale)
 eDMA drivers
Message-Id: <169683194737.43997.1440186102884737667.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:27 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 04 Oct 2023 10:32:28 -0400, Frank Li wrote:
> Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
      commit: 9f895354cc3cf4fbff21c922a5721691ed40589d

Best regards,
-- 
~Vinod


