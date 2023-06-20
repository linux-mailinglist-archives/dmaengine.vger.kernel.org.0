Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7029C7367C2
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjFTJcK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTJcJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 05:32:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B2A3;
        Tue, 20 Jun 2023 02:32:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b45e347266so52743361fa.0;
        Tue, 20 Jun 2023 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687253524; x=1689845524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6RkSlx8XrZO42soMnBgsxTLxMlxCujpuFknxlHA8No=;
        b=dErJ47XQjru8Dnpwi9O3bsjz0RkdABiKWekKtr6D+rp4ScIUbSBBTab5ykpNkeqpk5
         GGx7VSKgpWRXEfEL/o6U0LY9mp9lxcsRjxo2dlL+HD81r8iVx9MoIrwBqHPLb3bPy9Rv
         5DybStrHiQYDfUMRzbYQjX7BH+rSvAQYLcxZsjkVwpv32gXT9IIScbNIYoRXNLI7tHT6
         Ly0UuLapXIwAAFfDuW4iGMWhUbTrVHnaw4V5r8vL2TVQkN386rPbHd//rEmINMn6zESq
         CYS1CsS+V+zhlLl0dE8angqDDEcdmko5rGi00JOjo0Xf8LSKUPZxmWU1ogRMCmwGJiKC
         xR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687253524; x=1689845524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6RkSlx8XrZO42soMnBgsxTLxMlxCujpuFknxlHA8No=;
        b=UTMUMbo+YOyzEkPsl4YCpQVFKUFss7P/IAYxDisoJdTlRQ27N8cqhm3fGKQG8JqNYK
         2qO8Xk7rasiSaaQBQLRJxDHbCG62OpmZAe3flrssGisbj6pUS4NMq5py+2MedWeQHxfS
         SR8u369BC9MomIAnl6s3t13aak6qlIfXzdqgedEelMbTAbbC/YQFYpO7fVtr5HmBjeLK
         +PwNPBUtPTI/jsjlfxzQnBQUc3UKHlIr5psarC4gMfcWcmNahefg6lF6OfjATNBsu0cc
         Cx5ad9elgdj6HWZ90NlueN0tvQvhBW8SdBPcEmK5HumynBl0+vAK+lnIQbj5ZZyn0aB/
         c+rw==
X-Gm-Message-State: AC+VfDwPh68oIASMhxajSpmSf2IIJni0t/VXEPdPUe//gTiTvaKyGMrv
        l54xxYCfRjUpWTcgZlmUfTg=
X-Google-Smtp-Source: ACHHUZ7QGXkEQcR1w/mpgxAX9QYVbM7QjYWB7mf7+ASrvwJ5KxydoASvzKSFPmgYaRiRwE1L6qaUgA==
X-Received: by 2002:a2e:8088:0:b0:2b4:7f66:8c92 with SMTP id i8-20020a2e8088000000b002b47f668c92mr2968973ljg.31.1687253523620;
        Tue, 20 Jun 2023 02:32:03 -0700 (PDT)
Received: from mobilestation.baikal.int ([94.125.187.42])
        by smtp.gmail.com with ESMTPSA id n10-20020a2e878a000000b002ad8fc8dda6sm330032lji.17.2023.06.20.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 02:32:03 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:32:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 3/9] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
Message-ID: <20230620093201.33vmdmgczwma5iat@mobilestation.baikal.int>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-4-kory.maincent@bootlin.com>
 <20230618214800.5h4ni43vu2admho5@mobilestation>
 <20230619201647.7cfe12c9@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619201647.7cfe12c9@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 19, 2023 at 08:16:47PM +0200, Köry Maincent wrote:
> On Mon, 19 Jun 2023 00:48:00 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > Seems reasonable especially seeing there is a code with a similar
> > semantic in the dw_hdma_v0_core_write_chunk() method.
> > 
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > Just curious whether we really need to have the local IRQs left
> > enabled for the remote device setup... The only case I have in mind is
> > that it would be useful to signal a remote end-point host of such
> > event in some application-specific environment. It sounds exotic but
> > still possible.
> 
> Thanks for your review.
> Yes, we do need to let local IRQs enabled. I have tested to remove them and it
> prevent the remote setup to function correctly on my board. Maybe it needs to be
> set to know internally when the transfer is done, but it seems weird. I haven't
> a full explanation for now.

Ok. Thanks for checking it out.

-Serge(y)
