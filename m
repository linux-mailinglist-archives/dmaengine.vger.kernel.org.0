Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954055EEF49
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiI2Hjz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiI2Hjn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 03:39:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2EDFBD;
        Thu, 29 Sep 2022 00:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E56B8237F;
        Thu, 29 Sep 2022 07:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A30EC433C1;
        Thu, 29 Sep 2022 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664437178;
        bh=/n0Q5GrDswm33XQryPk2WZzaKOv8olLq/q5OJ+haq8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NsW8RsuHm4QnUnWi2FkTGxNhOG8d32sArCS4R36OXrkt0D32MDXCs1dNvI3AvIqdc
         0PJeJoAMDcH9y8nXUqG8Q+jdOIfchHgskqry8mLcc1J1i66DYMhKIFBU+Am7m65+o+
         /as1AU+60kbmZ169h55koVVqt+91s3ltF/gAxSiA7Y56GjoTzkaaUfkcEsA4OJkV4T
         YCsmmvC/gPBvfxKq4CJaRrPpY1y4y4VZ4LtUSDj5rzJJrjqZ2NFfqBWPwNcWHUANGP
         N2IhLoFT99em2xOc3vPMRX8WmowmfHF7DqkR19sjXPJeccmfDmGviFLNg/RhKTQynS
         G3ngm8ghjpp8A==
Date:   Thu, 29 Sep 2022 13:09:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: qcom: gpi: add fallback
 compatible
Message-ID: <YzVLtvPk6YiDfBtb@matsya>
References: <20220923210934.280034-1-mailingradian@gmail.com>
 <20220923210934.280034-2-mailingradian@gmail.com>
 <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-09-22, 23:26, Krzysztof Kozlowski wrote:
> On 23/09/2022 23:09, Richard Acayan wrote:
> > The drivers are transitioning from matching against lists of specific
> > compatible strings to matching against smaller lists of more generic
> > compatible strings. Add a fallback compatible string in the schema to
> > support this change.
> 
> Thanks for the patch. I wished we discussed it a bit more. :)
> qcom,gpi-dma does not look like specific enough to be correct fallback,
> at least not for all of the devices. I propose either a IP block version
> (which is tricky without access to documentation) or just one of the SoC

You should have access :-)

> IP blocks.

So knowing this IP we have two versions, one was initial sdm845 that
should be the base compatible. Then second should be sm8350 which was
the version we need ee_offset to be added, so these two can be the base
ones for future...

My 0.02

Thanks
-- 
~Vinod
