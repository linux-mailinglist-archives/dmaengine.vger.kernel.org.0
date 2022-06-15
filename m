Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1C54CFA6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbiFORXr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346434AbiFORXq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 13:23:46 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14231504;
        Wed, 15 Jun 2022 10:23:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1655313819; bh=ix8DuR7FVhlX1QFc3YVDpB6U+OMwX3Iyaeweg0Q0V5g=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=i/ajhs61AwEz0DHh1hHE75q/NqJnwpTVYAKzTBsBz82OO/tDa+YuylRBkcnv8A3wY
         +CoFqyytpaWwe59entSjJYypvIRTr2VnJGhp11D6wH59fKHy7X50D/8fKlvcNWgYTZ
         PQoTr7SZjw/k0qQ0DQfewKbWP0f/G9kpzcELljPY=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: linux-next: Tree for Jun 15 (drivers/dma/apple-admac.c)
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <CAK8P3a2mQiWKyVux+bfAJiRH=72q76UTLZnBbPCLVFVoXpGfaw@mail.gmail.com>
Date:   Wed, 15 Jun 2022 19:23:37 +0200
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <334755C8-8FF2-49D3-ACC3-C76F3BCCBB4F@cutebit.org>
References: <20220615160116.528c324b@canb.auug.org.au>
 <1f8095db-a08f-7b6b-2cee-f530d914b9f8@infradead.org>
 <CAK8P3a2mQiWKyVux+bfAJiRH=72q76UTLZnBbPCLVFVoXpGfaw@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 15. 6. 2022, at 19:10, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> On Wed, Jun 15, 2022 at 6:28 PM Randy Dunlap <rdunlap@infradead.org> =
wrote:

>> On 6/14/22 23:01, Stephen Rothwell wrote:
>>> Hi all,
>>>=20
>>> Changes since 20220614:
>>>=20
>>=20
>> on i386:
>>=20
>> ../drivers/dma/apple-admac.c: In function =
'admac_cyclic_write_one_desc':
>> ../drivers/dma/apple-admac.c:213:22: warning: right shift count >=3D =
width of type [-Wshift-count-overflow]
>>  writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
>>                      ^
>=20
> This should probably use lower_32_bits()/upper_32_bits() then.
>=20
>       Arnd

Here=E2=80=99s a patch to use lower/upper_32_bits that=E2=80=99s been =
posted.

=
https://lore.kernel.org/dmaengine/20220614074915.1443629-1-geert@linux-m68=
k.org/

Martin

