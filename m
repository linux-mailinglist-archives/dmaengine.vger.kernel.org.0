Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9E5AC561
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIDQXe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDQXd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 12:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A822B24A;
        Sun,  4 Sep 2022 09:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AF55B80DB0;
        Sun,  4 Sep 2022 16:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E62C433D6;
        Sun,  4 Sep 2022 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308609;
        bh=EGjh7mS5zJnu1xp3jsOWXePLs1ZonDTFOjM6Yw4z0sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4YB9JMuAOXI9y1z4Z55HvKxWVmKoRXckM/SnJILzF0v2X2OVMyE0UwdoXdOquFkn
         e6DZ8zFJDOjQkUJJwKH1qEnpOtNOEFmJ80QRG5lyoOcP/K5HyzX+an82zVepWizoun
         r1BXNl9zmT/E4vOJVJ6lnfMDXo3EAd+sv1vmG2VvgoB+/hY9yLz38q/RkYtmH9t5jG
         iwRdhqAE/kjtOWOlbpQ2jo06yHgbYYfW5cVETBGSMFF2TxZ+Meyz6FnqT9h/cONpk2
         zzb6WYESAKi2jis1rd6V9D5IuZnN7yW86nfffHjrYYnwLAmZ6SXfdGjcTi6KqRcV+x
         osUQoWho/LAmQ==
Date:   Sun, 4 Sep 2022 21:53:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add GPI DMA support for SM6350
Message-ID: <YxTQ/A8i0HpAO9om@matsya>
References: <20220812082721.1125759-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812082721.1125759-1-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-08-22, 10:27, Luca Weiss wrote:
> This series hooks up GPI DMA support for the SM6350 I2C.
> 
> It has been tested using himax,hxcommon driver that I forward-ported
> from the original vendor kernel on fairphone-fp4 - previously I have
> used i2c-gpio bitbang in my tree.

Applied 1-2, thanks

-- 
~Vinod
