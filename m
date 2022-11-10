Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E12462414C
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 12:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiKJLXF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 06:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiKJLXA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 06:23:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ADF1B1E3
        for <dmaengine@vger.kernel.org>; Thu, 10 Nov 2022 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668079317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSoTGJHYNk5kLWvsAfIAZIF6vg0FfWUEQ1onckotlr8=;
        b=Nst0KgAqQd7IPLIQuT6+B+9nnnGwoMJpVVDLL9XxPS9HpH+UoDwMIG6GhJVYp0B+K0cr/H
        2SMKIyqIQDBynWQj2IKAXC3DDjDJ8BQUOvs/O9c9FBBlu4CIdXRoi3PA7PG0BcXQMED51x
        SUvE9siOLstacixElYt7Gc8tncnfPCU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-TXhLEBcbNPGY_H0Wx6yE3A-1; Thu, 10 Nov 2022 06:21:56 -0500
X-MC-Unique: TXhLEBcbNPGY_H0Wx6yE3A-1
Received: by mail-pf1-f200.google.com with SMTP id z19-20020a056a001d9300b0056df4b6f421so917309pfw.4
        for <dmaengine@vger.kernel.org>; Thu, 10 Nov 2022 03:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSoTGJHYNk5kLWvsAfIAZIF6vg0FfWUEQ1onckotlr8=;
        b=1Ref4pbJ2JgRvQ9OKOfbQJfgEReSqiNDVFFJFiCCPk3pguG402tEJ+8jCzRD1vir91
         SgqKngj5U6ciCNoxXuKuQLfLwteOBADrpbW8U5X10QDpAzGtWA4RrMJaaw4D43uIJp+y
         EAhxdqCrvNNYzyX2dmelZq6NmnMeX+52n3Ee5+kS8iE2/H69fJ+6NbbpvJorHzycmC2X
         vxTk3BSybb9mN0OeIxucWMswAvGde8vGn4dCklRydGBVIcd2D6d/XAN9+k3fneY+AAX+
         8HymODq2MU2EK9loP6t4JMtw/TtVJBSkF4ImTAKYamVPX/nn3d7JTneXUkRhRClGH0RM
         ZlCA==
X-Gm-Message-State: ACrzQf2iA+aUSkz8BBzI3+ONZXlR7Hj9d9+pscBOQhf915PmSN6MBthf
        STC2lqXPujYYWj1GgcDGpAxbu7Abv/YmeZKM12X4gYa4kZpGcB91Mc/XrMSKDDf0JCbhKfgDO6n
        f2P8VsZdtfWXgfX0gr4F+
X-Received: by 2002:a62:1ad6:0:b0:56e:5bcd:d025 with SMTP id a205-20020a621ad6000000b0056e5bcdd025mr2207389pfa.65.1668079315523;
        Thu, 10 Nov 2022 03:21:55 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4Bo69JRApM5YU7MX1qUs1b8/J7qBWEiTgAehtbNn8J8UY39JcJc1D66eCpsG9UzAOPRza39g==
X-Received: by 2002:a62:1ad6:0:b0:56e:5bcd:d025 with SMTP id a205-20020a621ad6000000b0056e5bcdd025mr2207379pfa.65.1668079315231;
        Thu, 10 Nov 2022 03:21:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a0000d200b0056c5aee2d6esm9958421pfj.213.2022.11.10.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:21:54 -0800 (PST)
Message-ID: <575fa0c61cb55845c4d3a646d0b1f48d782588a0.camel@redhat.com>
Subject: Re: [PATCH v4 4/4] net: ethernet: ti: davinci_mdio: Deferring probe
 when soc_device_match() returns NULL
From:   Paolo Abeni <pabeni@redhat.com>
To:     Nicolas Frayer <nfrayer@baylibre.com>, nm@ti.com,
        ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        grygorii.strashko@ti.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com
Date:   Thu, 10 Nov 2022 12:21:40 +0100
In-Reply-To: <20221108181144.433087-5-nfrayer@baylibre.com>
References: <20221108181144.433087-1-nfrayer@baylibre.com>
         <20221108181144.433087-5-nfrayer@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

On Tue, 2022-11-08 at 19:11 +0100, Nicolas Frayer wrote:
> When the k3 socinfo driver is built as a module, there is a possibility
> that it will probe after the davinci mdio driver. By deferring the mdio
> probe we allow the k3 socinfo to probe and register the
> soc_device_attribute structure needed by the mdio driver.
> 
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>

I guess this one will go via the arm tree, right?

I'm dropping it from the netdev PW.

Thanks,

Paolo

