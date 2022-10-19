Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B020604674
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiJSNKZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiJSNJm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:09:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1E46204;
        Wed, 19 Oct 2022 05:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A441B822BE;
        Wed, 19 Oct 2022 12:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81D9C433C1;
        Wed, 19 Oct 2022 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666183717;
        bh=2fsYk4dFVWmKjlpq+HQnGll4iwI/xoSs0bbcxy6tZcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce1pQtfymlJ3BDnszSC0kJUBdZVxt1i7p/pfNODdH53+E9TH5IHKeFyNx09ngOHi7
         NfrkvmjXkFpoi/mCM9OLcoGJYJui0TC3CV994tMGbEp+qXQXqXTP8Lg4pUQAEn88CP
         uIXwn2TgGnSnTfqmjh8UcFtNxQT0LVmwV+a0Gk8RorFSWLW/NCbRFFzkJaK3GEqvLd
         2uzvLCTWbrgY71+SvpTf37fsBVlHDjiwvxgUFPzHqWYz/1F8X7zxnZY9s7SZ7IFiAn
         fm44P/xMIhXWIl4T4Re3gKNqrwOaQZOdKvALdVMPTSZYmg+2TCh3+EwRFF9H/L1/zm
         14iytKggKr/Ng==
Date:   Wed, 19 Oct 2022 18:18:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/4] SDM670 GPI DMA support
Message-ID: <Y0/yISxJlE64xJ9O@matsya>
References: <20221018005740.23952-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018005740.23952-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-10-22, 20:57, Richard Acayan wrote:

> This patch series adds the compatible string for GPI DMA, needed for the
> GENI interface, on Snapdragon 670.

Applied 1-3, thanks

-- 
~Vinod
