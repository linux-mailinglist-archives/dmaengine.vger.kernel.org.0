Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A465A034F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiHXVeK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbiHXVeH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 17:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD95FAFF
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661376844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cnZB4/kxG5SzSCN2CWQT4rDr7KWqDzVyVVIFcXfgQM=;
        b=bTTVmU3kWUL7LBdJxTQHczpEHBc7qZnbK9S4/lnlzkldm+y6MWq2vMboA2krGV0txPSnf5
        QWXdkmxMwcu6ylEtnKEhNUBb4veCyGFsDruaKUyVSIizm6U9Ha2RmUsKPE9IIKVS6wcQUk
        fPxl59R0Vr9zBSgMl3e5OyzLjlWIzU0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-380-lw0eWdK1MCy3AKGvoxOoLg-1; Wed, 24 Aug 2022 17:34:03 -0400
X-MC-Unique: lw0eWdK1MCy3AKGvoxOoLg-1
Received: by mail-qk1-f197.google.com with SMTP id az11-20020a05620a170b00b006bc374c71e8so6395637qkb.17
        for <dmaengine@vger.kernel.org>; Wed, 24 Aug 2022 14:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=2cnZB4/kxG5SzSCN2CWQT4rDr7KWqDzVyVVIFcXfgQM=;
        b=8HXjNXpuRNF++ea3SaTxM+Pu25hLEryvlhg6eMwZsnwkcmF5DbZnz6aN3LeYgm5q4g
         8WOBvGCHvakqxkv552tefdeFFj4llnRKumjnahl23x6zaCpCC3pgdGUhyUpZfm3/6apG
         On7r3qW9NtWUcUy6MMFE3buegv7ABaO5yOk1oUST2M0RiKkv5Ddlwh08Q3DlFpij1UzT
         TJRqmQEuqLOmN61vTRt+ua8WVd/NKcayuBNBNOhCrZh6l1I5BPoHnR6Ddenny9lNlino
         8pIDhRAReHtj3Dgw+2L2FQfEnO8+meEjub9PdTuGxAe4kDC/CBUmDnohE48nWa/hYTo8
         dIww==
X-Gm-Message-State: ACgBeo0AKXgkDXNTXcdnlJlFEGxLakDScyuNfEuyRqwsOGdM/bLA5Byb
        WxXeSoWl/itPXAYIFf91Q51BsK604zwS43YH9uafp4w4YiJYKbdrgtFFnGDRCg+jLVSHM64CcLd
        duU+G/EYpwPsqWEcXS0lw
X-Received: by 2002:a0c:8ec4:0:b0:47a:aa82:58b6 with SMTP id y4-20020a0c8ec4000000b0047aaa8258b6mr1101005qvb.46.1661376842580;
        Wed, 24 Aug 2022 14:34:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7LxUBZZyk1oZ838GhE3PkTke8FDXLF93qqatyFqk9FsKOChbuDqNEDTkPMPH0cwnstfTqidg==
X-Received: by 2002:a0c:8ec4:0:b0:47a:aa82:58b6 with SMTP id y4-20020a0c8ec4000000b0047aaa8258b6mr1100986qvb.46.1661376842404;
        Wed, 24 Aug 2022 14:34:02 -0700 (PDT)
Received: from [192.168.1.52] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b17-20020ac84f11000000b0031e9ab4e4cesm13337901qte.26.2022.08.24.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:34:01 -0700 (PDT)
Message-ID: <33a546ea17fe62ca9fc763041fe340ad5e4945fe.camel@redhat.com>
Subject: Re: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zhu, Tony" <tony.zhu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Date:   Wed, 24 Aug 2022 14:34:00 -0700
In-Reply-To: <IA1PR11MB6097988CC9C2C1C713E3D8339B739@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
         <20220823163709.2102468-1-jsnitsel@redhat.com>
         <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
         <20220824005435.jyexxvjxj3z7tc2f@cantor>
         <223e5a43-95a5-da54-0ff7-c2e088a072e3@intel.com>
         <38e416b47bb30fa161e52f24ecbcf95015480fed.camel@redhat.com>
         <IA1PR11MB6097988CC9C2C1C713E3D8339B739@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2022-08-24 at 21:11 +0000, Yu, Fenghua wrote:
> Hi, Jerry,
>=20
> > I see another potential issue. If a software reset is attempted
> > idxd_device_reinit()
> > will be called which walks the wqs, and if a wq has the state
> > IDXD_WQ_ENABLED it calls idxd_wq_enable(), but the first thing
> > idxd_wq_enable() does is see that the state is IDXD_WQ_ENABLED and
> > returns 0.
> > Without the wq enable command being sent, it will not be re-
> > enabled, yes?
>=20
> Could you please describe how to reproduce the issues and test case?

Nothing special, just running dsa_user_test_runner.sh from idxd-config
(3.4.6.3) with intel_iommu=3Don,sm_on (default is lazy dma domain) on an
Intel supplied SPR system. During the run there is a dmar fault, halts
the device with it needing an flr reset. That is where the deadlock was
noticed. Then after the dsa_user_runner.sh fails, if you do modprobe -r
idxd, you hit the warning in devm_iounmap().

The idxd_device_reinit() case I haven't reproduced, I'm just looking at
the code.

I should note that I've only run into an issue with that model
of system. The other models of SPR systems don't hit an issue. This is
with a 6.0-rc1 kernel, and our kernel. I'm guessing there is an issue
with that model of system/fw. I've seen both fault reasons 0x50 and
0x58 when it faults.

Regards,
Jerry

>=20
> Thanks.
>=20
> -Fenghua

