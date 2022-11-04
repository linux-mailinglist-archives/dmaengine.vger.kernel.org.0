Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C1619A6B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiKDOpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiKDOpw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3535ECA;
        Fri,  4 Nov 2022 07:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73AF262229;
        Fri,  4 Nov 2022 14:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19792C433D6;
        Fri,  4 Nov 2022 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573148;
        bh=ba6lksJZIeZcdg9LepJPufgmfJL85013XOTWMji0zIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lt/rTbmgCk0u7Cen5P4xhUDuTBy+IYukc2A8kRBpjji/T/s7iyoaSGt4Mg4v3qm+q
         xnhsAreG7ap7j4OCPIn1qIUm/ww2cBdmu5rydzZZhxMpfMwfaLt7h9HKkol4Svn16f
         OjE/uoOSgp6TmKCweEirGhiY7J4h/Jk7ZInD3Njz1suloDXPA7a7GdIpmHq/51p0Xe
         O3dlj9zB9YNNaa7/9qKeul8PYnniDfRAmpFsgzg/KagBDYJB7ShIdWkA7LF/oefDEp
         9b5SL++sg03NVuU2fjSB5sgac9zxltsO8ebXERTil+TMlvD5CsArXAyElUkv3MIhHK
         uviDY3gvfXwsA==
Date:   Fri, 4 Nov 2022 20:15:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/8] dt-bindings: dmaengine: qcom: gpi: add compatible
 for SM6115
Message-ID: <Y2UlmJvfTqVDa138@matsya>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-4-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094258.486428-4-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-10-22, 11:42, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Document the compatible for GPI DMA controller on SM6115 SoC.

Applied, thanks

-- 
~Vinod
