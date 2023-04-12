Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A36DFC5E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLRNb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLRNa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B072117;
        Wed, 12 Apr 2023 10:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F067F637AA;
        Wed, 12 Apr 2023 17:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04F9C4339B;
        Wed, 12 Apr 2023 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681319600;
        bh=mUU/t30v6SjF9HmyrBzJN1lysUpIplFg9I0liCH0Tjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkvXhfjSV+BMhwwMA3Ih2yrD3glm9cMuANycWRSvgoEv4IIlhuuzV4qmOw/ykaIPt
         dyMeoufDBGkWTTbTUeFkNV2OBlzSULwyFkNH23pMKcAvq90L2IDcG8ohE5QaFFnToJ
         LCxF/YTzvVwyGImNMv4EjuSIzRxIt4jwgsD+qrj9+QtqnNNlOIKJxzKhGS8UdoihyS
         9zkRFC47ebvD5XmdAs3A94U9Rv7EbQocNujap7dQJbCcF43INDQ0UkJgshq3aeOTYg
         ivwHI7rHMnayXr7B9oLixu3mYJMDblLZEF0dIDyxIK5GYqCGok161vCiRc3GTiIo+E
         MO+/nxRZQhK3Q==
Date:   Wed, 12 Apr 2023 22:43:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: Add explicit platform_device.h
 and of_device.h includes
Message-ID: <ZDbmqyXn3CjqI/8S@matsya>
References: <20230410232654.1561462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410232654.1561462-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-04-23, 18:26, Rob Herring wrote:
> qcom_hidma uses of_dma_configure() which is declared in of_device.h.
> platform_device.h and of_device.h get implicitly included by of_platform.h,
> but that is going to be removed soon.

Applied, thanks

-- 
~Vinod
