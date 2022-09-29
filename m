Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593845EFBF3
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiI2R01 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 13:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiI2R01 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 13:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442D14A7AB
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664472385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EyJmMTqutL3Lku2JZ2dyQ6stk9i/1LzNE6W3+Pfwt4=;
        b=PQPU1DPbhcfJ21CswzNTZZve1luIV6NNU/poXqaoiwnKS6h0iOORt6gkE5rDFgGBoTOG1T
        /N0FXk6RZNdYAJNMahVABHeUTrnrI6OkcTvESu+DwcB+B2GVuiRUtLv9F8fViRp4qfg/iA
        qrxJTkCaNa3Pgx4xirUaBUNaRJzqCzo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-284-qPwK3mlSP6uV4FGfGUJmMQ-1; Thu, 29 Sep 2022 13:26:24 -0400
X-MC-Unique: qPwK3mlSP6uV4FGfGUJmMQ-1
Received: by mail-oi1-f200.google.com with SMTP id a26-20020aca1a1a000000b0034fdf34de68so874950oia.12
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 10:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6EyJmMTqutL3Lku2JZ2dyQ6stk9i/1LzNE6W3+Pfwt4=;
        b=R/2vkY9Vvm3tPT3Rk4gPK7g49XEkvCU6JZjRxWUqzRLIkEbmsFNPLqnWCoZwmFHvEE
         3Uw8S49Kjd3whPa4jjs7a+dV75CrS1HqNVY/EKCe5jcqp3NGoeN0kzyptQaw/ngwZh+X
         OLIU8EGeG5VOQVr7b8dOK/bstvf9RmeQmtjf/J+v6pjuDNAJV2nmRjJf/DZW6RdIVjHd
         V9yZ34RnIjW9vZkxhSBw8AuwlWmcXFnYftLzAxm+7GPwkB39yI9Tx+/L4rgWSm548gDp
         YI7+ehrt86QDhJzHo5aoQtYBUJWJK4sBCIBj+rdZoyb1htiJoyvnc5BEsRTUWR71grsR
         PXSA==
X-Gm-Message-State: ACrzQf3jdBpTJVk9xS2heTjIrxhpMrnvb0C/33eny3DIAD/mAW6wooid
        bM/rlpeKOP5WFeV+Q3KWVn/8n2AtWTaXwuPJ7IfIWgdPFa1ayWGpNNSFkiWrkabfILufHCWJlp0
        tbX5KCgobLvlHbWvE9VCo
X-Received: by 2002:a05:6870:46a6:b0:12d:130c:2fd5 with SMTP id a38-20020a05687046a600b0012d130c2fd5mr8931880oap.92.1664472383087;
        Thu, 29 Sep 2022 10:26:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4le1yaUd/iytxRMieJ2Zmv7xiQLbc05aejyCDQqd4KJ09PnAlJheP6tmqKbeQ+3RpOZ+pqqg==
X-Received: by 2002:a05:6870:46a6:b0:12d:130c:2fd5 with SMTP id a38-20020a05687046a600b0012d130c2fd5mr8931870oap.92.1664472382893;
        Thu, 29 Sep 2022 10:26:22 -0700 (PDT)
Received: from [192.168.1.35] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e190-20020a4a55c7000000b0044b491ccf97sm28212oob.25.2022.09.29.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:26:22 -0700 (PDT)
Message-ID: <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Koba Ko <koba.ko@canonical.com>
Date:   Thu, 29 Sep 2022 10:26:20 -0700
In-Reply-To: <YzXRbBvv+2MGE6Eq@matsya>
References: <20220830093207.951704-1-koba.ko@canonical.com>
         <20220929165710.biw4yry4xuxv7jbh@cantor> <YzXRbBvv+2MGE6Eq@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
>=20
> >=20
> > Hi Vinod,
> >=20
> > Any thoughts on this patch? We recently came across this issue as
> > well.
>=20
> I have only patch 3, where is the rest of the series... ?
>=20

I never found anything else when I looked at this earlier.
The one=C2=A0thing I can think of is perhaps Koba was seeing multiple
issues at time when he found this, like:

https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canon=
ical.com/

That was also being seen by an engineer here that was looking
at client_count code.

Koba, was this meant to be part of a series, or by itself?


Regards,
Jerry

