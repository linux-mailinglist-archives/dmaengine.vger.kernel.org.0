Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3B362136
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhDPNko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Apr 2021 09:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhDPNko (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Apr 2021 09:40:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B11D6113B;
        Fri, 16 Apr 2021 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618580419;
        bh=HV+Sa06TNNKRjdnGUqORLmRRbgRPv/iaPKadUfOn/NE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JIPkl8/Hh8RdKXsbE9uAFBf0kX25Nq4J2d8XjtA1nDtRXKgpZOjv763HWPl1KpjeF
         JFdTefkXXbfd+a/Vr3P0Y8u7Bo0ErLV9yYpGr/USWLBUR8+R+OhJAJdy9kyxErc1uf
         YRhuBDEuX0c7eSnJdcXkU0w7DBDPSAE/d/1OL3LxstfcKA7X3pPtJlWr+7gefk9yXy
         yQ7libYbP7YnWfePKxW1NxNnLvoJLdmEPfQg/SWk6eyTqr8v9r9e1EJUacnXTWURkt
         ha3/5kdAaDIDmramvAkGnuI5z3lH81eZSRtLzstayr3zJIWXCqsCBDpDGQRLJLAAej
         d2LbnKQshL7Og==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: Re: [PATCH 2/2] arm64: boot: dts: qcom: sm8150: Add DMA nodes
In-Reply-To: <20210416133133.2067467-3-balbi@kernel.org>
References: <20210416133133.2067467-1-balbi@kernel.org>
 <20210416133133.2067467-3-balbi@kernel.org>
Date:   Fri, 16 Apr 2021 16:40:15 +0300
Message-ID: <87v98mmjpc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hi,

Felipe Balbi <balbi@kernel.org> writes:
> @@ -612,6 +636,8 @@ spi0: spi@880000 {
>  				pinctrl-0 = <&qup_spi0_default>;
>  				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>  				spi-max-frequency = <50000000>;
> +				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
> +				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;

one little note. This was for a quick test. I can either remove, keep it
or complete with the rest of the SPIs in this same patch. Let me know
what y'all prefer :-)

-- 
balbi
