Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689C6370D8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Nov 2022 04:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXDO3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Nov 2022 22:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKXDOY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Nov 2022 22:14:24 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4377202;
        Wed, 23 Nov 2022 19:14:23 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 9so471732pfx.11;
        Wed, 23 Nov 2022 19:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eV9Vty9UioHPXG+7Z49fEwX2mXa79xcuBVejyPSsgU=;
        b=KxZSfqXlnCWaBcXEPM+UKWwas6eD5rxuXSaY2yeaKRo3uqckgZ2hsvy3Br3kA2pLXB
         yUYySLxXqJUACOTku5Hoxhrtd+cAM0K5+WaHpPsYUM4iliPYWEsdF8T54JIiJYqoupZT
         Zf6oeSe2PqWVGRCiLEfVSUwtTRuEo0et/4xGmf+6sXg+ghlz/RoopmNgG+1kl/x24VRu
         MCaVAr5bONmI5yRTPnwzC8fwWlCSOIpy5AkFB9BGc0IpoVIFRHbANiikyuggGv72KzkW
         2HAzfR9ou0xPb3GRPxpA0PLVoB4Di92AJARNq3tLlgteA22L9UpIc8uKizzAqeTgE3z5
         fMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eV9Vty9UioHPXG+7Z49fEwX2mXa79xcuBVejyPSsgU=;
        b=ivCVuZXiN9ANY4Zi6vsvmBlORbUhxls7OZZ5LiyKcXw2AGF2ucpix0XYC65mcpsXyG
         B4LRjRdYE35Lenbpz9+f74ILOiWV130qs/AzPQqefWqakcytiFqPqz/3tKikfAuPM43r
         DuiA48L92NjnNeQRDVRk2JhTwxk8CGVZPXMw4iLK3QCD4FC1/Qcjq2uw8JptmA84f5GP
         SyyZKe6r63ZxOtPDHZ7Uy4D69bfRU2aV/2ZrIZgLj8oQ7QItOjftTdFDevB1L1F80cNe
         G5ifwuopnfUlTyTP4hdfR/b1gTwDTKON7HzVGVOovwzxGZQdpTAI2IRw5bZ6qBuU0m8s
         AidQ==
X-Gm-Message-State: ANoB5pmiUYcpcdG3V+YhX1jFGvC40C2E+YNzh4o/6epOV89c44gySE4d
        HbH4oAbE4XHP1Q9zNcrA5Kw=
X-Google-Smtp-Source: AA0mqf7CrYVYWYFErY6Otr1YcZCOCs7kgEP8DZLXoU1xgw4pN2mYtw/mEvG2GJEWvcW1/Ze6OSf/eQ==
X-Received: by 2002:a63:155e:0:b0:476:95a8:de91 with SMTP id 30-20020a63155e000000b0047695a8de91mr9916512pgv.102.1669259662477;
        Wed, 23 Nov 2022 19:14:22 -0800 (PST)
Received: from localhost ([2406:7400:61:64d5:6ced:a13c:ba7b:305b])
        by smtp.gmail.com with ESMTPSA id s23-20020aa78bd7000000b0055f209690c0sm13463535pfd.50.2022.11.23.19.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 19:14:21 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Nov 2022 08:44:15 +0530
Message-Id: <COK75VDFXZSZ.TLR6MVN7TUMN@skynet-linux>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 0/3] dmaengine: Add support for immediate commands
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
X-Mailer: aerc 0.13.0
References: <20221027051429.46593-1-sireeshkodali1@gmail.com>
 <Y2UIS7P0alvqT4jn@matsya> <CO97J91UP8IF.23GNHUUM2KTVH@skynet-linux>
 <Y3FudBqc1vQ8fEgU@matsya>
In-Reply-To: <Y3FudBqc1vQ8fEgU@matsya>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon Nov 14, 2022 at 3:53 AM IST, Vinod Koul wrote:
> On 11-11-22, 10:42, Sireesh Kodali wrote:
> > On Fri Nov 4, 2022 at 6:10 PM IST, Vinod Koul wrote:
> > > On 27-10-22, 10:44, Sireesh Kodali wrote:
> > > > The IPA v2.x block, found on some older Qualcomm SoCs, uses BAM DMA=
 to
> > > > send and receive packets from the AP. It also uses BAM to receive
> > > > commands from the AP (and possibly the modem). These commands are
> > > > encoded as "Immediate Commands". They vary from regular BAM DMA
> > > > commands. Adding support for immediate commands is trivial, but req=
uires
> > > > also adding Immediate Commands to the dmaengine API, which is what =
this
> > > > patch series does.
> > >
> > > Can you explain a bit more. I understand you need "Immediate Commands=
"
> > > but am really reluctant to add another interface to support a specifi=
c
> > > use case
> > >
> >=20
> > Apologies for the delayed response
> >=20
> > BAM supports both regular commands, and "immediate commands". Currently=
,
> > commands are used by the Qualcom NAND chip driver, while "immediate
> > commands" are intended to be used by the (yet to be mainlined) IPA
> > driver. From the BAM driver perspective, both immediate and regular
> > commands are simply a matter of setting the appropriate flag in the
> > descriptor. I don't have access to the documentation on BAM to know
> > exactly how these two modes differ, however I do know they are not
> > interchangable. If a different API is suggested, I can change the
> > implementation as needed.
>
> Ok, can you please explain what is meant by 'regular' cmd and
> 'immediate', lets see what is required here

I unfortunately don't have access to any documentation that explains the
difference between the two. All I know is that IPA requires using
immediate commands, while the QCOM NAND driver requires using 'regular'
commands.

Regards,
Sireesh
>
> --=20
> ~Vinod

