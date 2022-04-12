Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D424FE0D2
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiDLMu3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354887AbiDLMrs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 08:47:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7081659;
        Tue, 12 Apr 2022 05:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1993CB819FD;
        Tue, 12 Apr 2022 12:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6986C385A5;
        Tue, 12 Apr 2022 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649765633;
        bh=DfRyEVEg86dGnm/EsQT+d1NwNbRRLIhpAm7MMVoLNL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baijqGW+mNa9LQ5Y5qEkc5GHOpGJnvHiDCb9EYqpzYnmE9rFomBDbNs95znu5hfHE
         Ny8diBnMrSZmf3OotdyW+IOJMRBEVuuMlSfYCXRWeW7XBD3MDPLhSoRlDJ7HY4PidR
         SF/AFKANduFWujH2DioovXn6Bv3GR236gzFP6ZwnwH9qhB4UwEXmDbjuqXSRFS4H5w
         gp7mbNIHpHxmX+Xju7xg3AXYHy0k0WHThlaC0RjuOxFmQJRpLr4FF4P37b9hJkNZSj
         au2YPay1E6j33Ek3YcR3VYfruPUFplfF4Vf178qHHQZXRN6KgVYbikP4NMqaoXjx+5
         Q9EUbgKXwlnAA==
Date:   Tue, 12 Apr 2022 17:43:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v9 1/9] dt-bindings: dmaengine: Introduce RZN1 dmamux
 bindings
Message-ID: <YlVs/TDodn2B0WxN@matsya>
References: <20220412102138.45975-1-miquel.raynal@bootlin.com>
 <20220412102138.45975-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412102138.45975-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-04-22, 12:21, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
