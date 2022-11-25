Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D593638E95
	for <lists+dmaengine@lfdr.de>; Fri, 25 Nov 2022 17:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKYQvB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Nov 2022 11:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKYQuo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Nov 2022 11:50:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2421807;
        Fri, 25 Nov 2022 08:50:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so8190283pjc.3;
        Fri, 25 Nov 2022 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfwYrXaErbUOWjxPsFIISqMfJIaUdzQIGOvRpzN2nKo=;
        b=fdDp0H4hxYRT1ClITZUPzA9Z0MOpbSjNBJUlpGkKulzi2+EPfVXSv5rRC3SI1rSOeC
         idMuUqX6c8wTWmFGPKBF0Gsw+uHdje5XddS8Mmn7IxIIgx8w5Gum7VQIH/EciGDgr1DM
         wcsLhr2PHKIeuJ4HisY6pBZlCXcbJ0rz418q4AGSGTgT8rGYvIDf9CrRnZ5eH2UycxJs
         qaf4znjab6StYPkBciCM90APwXvrymrsd9thMO3iSKrHC/9c7gkM5JnAX3Rif3ltIc+Q
         r/7tgShFpCFubWcpPOSkHwOKh9lUQV9+OKiwzLTvquKMnra9H9xTtHwz351n1G8IMn9P
         RMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KfwYrXaErbUOWjxPsFIISqMfJIaUdzQIGOvRpzN2nKo=;
        b=zuNcyW9nQN9KwJjE7bIknU9DYpoQCQsb7mQONUrjjb3FivqeAIRZEGjUbTePv+Veuh
         /BKWHy7O66v6M8Dm8P5CdkuhLF6qhqgzx1ouJJsOrtlI8q0343PlRBQ/CmnalRGBKa2t
         LAE6oCgXeJYF4JiURd1GfXjISOHmda6LwD/myCIj87jeGsridfevMjK2+yAN9cxbOYzm
         gGt+Dho68nnNrg9FHX0IzMs0PmSP2qkujoTZauSpigMSYtPi7e1gu4mSm1isD+VXCuz6
         A25+RAY5NfUPpUjfS5WoGBbdqVp/Fm1N5eeE+r/yUw3PpVTx5ylszZzDcuPY4wlzmwsy
         OyJw==
X-Gm-Message-State: ANoB5pk+VdawEZofoY47vZbvbJgIm4BVUOls5j/EX8+bjFwUnKhct7IQ
        49EJziT+7kNFoaYEOazxUd0sHxiaBf2+QA==
X-Google-Smtp-Source: AA0mqf591/LJdyKcke50EoqPhdMIyJAjyg8qfuWkR0iQ/7OJ+TNiOSQ+wOnprJ1xunlHvIBDl56Mrw==
X-Received: by 2002:a17:902:dacd:b0:189:6889:c309 with SMTP id q13-20020a170902dacd00b001896889c309mr3481534plx.3.1669395025398;
        Fri, 25 Nov 2022 08:50:25 -0800 (PST)
Received: from localhost ([2406:7400:61:64d5:6ced:a13c:ba7b:305b])
        by smtp.gmail.com with ESMTPSA id x80-20020a633153000000b004308422060csm2805793pgx.69.2022.11.25.08.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 08:50:24 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 22:20:18 +0530
Message-Id: <COLJ587CFY67.2E0WQZD08PLBY@skynet-linux>
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

Stephan pointed out the APQ8016E TRM has details on BAM. As I understand
it, 'regular' commands are queued register read/writes for the
peripheral. Immediate commands on the other hand seem to be interpreted
by the peripheral's firmware, and don't involve any register
writes/reads from BAM's perspective.

This is what the TRM has to say:

> Immediate (IMM) (only for BAM-NDP): Allows the software to create
> descriptors of type immediate, which does not generate any data
> transmissions or registers configuration, it is simply supplied to the
> peripheral, the peripheral then parses its fields (which are
> irrelevant to the BAM). Only the flags of this descriptor are relevant
> to the BAM, address and size are irrelevant, and BAM simply passes
> them as is to the peripheral. This can be used for the software to
> operate peripheral-specific operations within regular data operations.
> Immediate descriptors are published on the sidebands as 1 byte size
> descriptor, once BAM_NDP fetches an immediate descriptor, it publishes
> all recently fetched descriptors including the immediate descriptor
> with immediate indication, to inform the peripheral that the last
> published descriptor was immediate descriptor.

> Command (CMD) (only for BAM-lite and BAM-NDP): Allows the software to
> create descriptors of type command. Descriptors of type command do not
> generate any data transmissions but configure registers in the
> peripheral (write and read registers operations)

Regards,
Sireesh
>
> --=20
> ~Vinod

