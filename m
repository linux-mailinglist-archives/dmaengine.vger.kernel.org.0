Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16C77F52A
	for <lists+dmaengine@lfdr.de>; Thu, 17 Aug 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjHQL0X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 17 Aug 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350333AbjHQL0R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Aug 2023 07:26:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A435A0
        for <dmaengine@vger.kernel.org>; Thu, 17 Aug 2023 04:25:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-dOULvA-BN-q2BWVbdPtlQg-1; Thu, 17 Aug 2023 12:25:35 +0100
X-MC-Unique: dOULvA-BN-q2BWVbdPtlQg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 12:25:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 12:25:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'coolrrsh@gmail.com'" <coolrrsh@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH] dma: dmatest: Use div64_s64
Thread-Topic: [PATCH] dma: dmatest: Use div64_s64
Thread-Index: AQHZ0AeULU9mW46wa0OxWq5lt3Wbdq/uV53w
Date:   Thu, 17 Aug 2023 11:25:32 +0000
Message-ID: <ab54155f8ed241eabe006700eb4b4511@AcuMS.aculab.com>
References: <20230816060400.3325-1-coolrrsh@gmail.com>
In-Reply-To: <20230816060400.3325-1-coolrrsh@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: coolrrsh@gmail.com
> Sent: Wednesday, August 16, 2023 7:04 AM
> 
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> In the function do_div, the dividend is evaluated multiple times
> so it can cause side effects. Therefore replace it with div64_s64.

Nope, and even if it did it wouldn't matter here.

> This fixes warning such as:
> drivers/dma/dmatest.c:496:1-7:
> WARNING: do_div() does a 64-by-32 division,
> please consider using div64_s64 instead.

What you should really do is look carefully at the domain
of the input values to see if the division can actually
overflow.

That message is basically incorrect.

The full 64x64 divide is horribly slow on all 32bit archs.
It is even about twice as slow as the 64x32 divide on Intel
x86 cpu in 64bit mode (regardless of the values).

	David

> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
>  drivers/dma/dmatest.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index ffe621695e47..07042f239db8 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -9,6 +9,7 @@
> 
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/math64.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/freezer.h>
> @@ -493,7 +494,7 @@ static unsigned long long dmatest_persec(s64 runtime, unsigned int val)
> 
>  	per_sec *= val;
>  	per_sec = INT_TO_FIXPT(per_sec);
> -	do_div(per_sec, runtime);
> +	per_sec=div64_s64(per_sec, runtime);
> 
>  	return per_sec;
>  }
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

