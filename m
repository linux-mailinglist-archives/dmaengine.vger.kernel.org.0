Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA91D9677
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2020 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgESMks (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 May 2020 08:40:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47750 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESMks (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 May 2020 08:40:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JCehuj048540;
        Tue, 19 May 2020 07:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589892043;
        bh=ISpvMNynT901AFM1KExDp2Nl0a40pyOTaflnMqw8SGI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qIDEvivyIz7f5r1pfosmvxnV4AfD+tppS2M7bcnsVLp38W+gUeNLx/aUU92z9sSZ6
         NAVjsekU77hjLSoaeDytOh4razjAJvJrhgj141R+EQLZFEE9CXhOVtQfnTxX18F/99
         jYSMeFBTkGiB3YhyJiMJHl49MkXz64UOimU+Dknc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JCehjH014632;
        Tue, 19 May 2020 07:40:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 07:40:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 07:40:43 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JCefuY015693;
        Tue, 19 May 2020 07:40:41 -0500
Subject: Re: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
 <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
 <20200514182344.GI14092@vkoul-mobl>
 <20200514200709.GL5955@pendragon.ideasonboard.com>
 <20200515083817.GP333670@vkoul-mobl>
 <20200515141101.GA7186@pendragon.ideasonboard.com>
 <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
 <20200518143208.GD5851@pendragon.ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <872d2f33-cdea-34c3-38b4-601d6dae7c94@ti.com>
Date:   Tue, 19 May 2020 15:41:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518143208.GD5851@pendragon.ideasonboard.com>
Content-Type: multipart/mixed;
        boundary="------------AED669D0BE743787B7469DAE"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------AED669D0BE743787B7469DAE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

HI Laurent,

On 18/05/2020 17.32, Laurent Pinchart wrote:
>>>>>>> @@ -176,6 +177,11 @@ struct dma_interleaved_template {
>>>>>>>   * @DMA_PREP_CMD: tell the driver that the data passed to DMA AP=
I is command
>>>>>>>   *  data and the descriptor should be in different format from n=
ormal
>>>>>>>   *  data descriptors.
>>>>>>> + * @DMA_PREP_REPEAT: tell the driver that the transaction shall =
be automatically
>>>>>>> + *  repeated when it ends if no other transaction has been issue=
d on the same
>>>>>>> + *  channel. If other transactions have been issued, this transa=
ction completes
>>>>>>> + *  normally. This flag is only applicable to interleaved transa=
ctions and is
>>>>>>> + *  ignored for all other transaction types.
>>
>> It should not be restricted to interleaved, slave_sg/memcpy/etc can be=

>> repeated if the DMA driver implements it (a user on a given platform
>> needs it).
>=20
> As mentioned in the commit message, I plan to extend that, I just didn'=
t
> want to add the checks to all the prepare operation wrappers until an
> agreement on the approach would be reached. I also thought it would be
> good to not allow this API for other transaction types until use cases
> arise, in order to force upstream discussions instead of silently
> abusing the API :-)

I would not object if slave_sg and memcpy got the same treatment. If the
DMA driver did not set the DMA_REPEAT then clients can not use this
feature anyways.

> I can extend the flag to all other transaction types
> (except for the cyclic transaction, as it doesn't make sense there).

Yep, cyclic is a different type of transfer, it is for circular buffers.
It could be seen as a special case of slave_sg. Some drivers actually
create temporary sg_list in case of cyclic and use the same setup
function to set up the transfer for slave_sg/cyclic...

>>>>>>>   */
>>>>>>>  enum dma_ctrl_flags {
>>>>>>>  	DMA_PREP_INTERRUPT =3D (1 << 0),
>>>>>>> @@ -186,6 +192,7 @@ enum dma_ctrl_flags {
>>>>>>>  	DMA_PREP_FENCE =3D (1 << 5),
>>>>>>>  	DMA_CTRL_REUSE =3D (1 << 6),
>>>>>>>  	DMA_PREP_CMD =3D (1 << 7),
>>>>>>> +	DMA_PREP_REPEAT =3D (1 << 8),
>>>>>>
>>>>>> Thanks for sending this. I think this is a good proposal which Pet=
er
>>>>>> made for solving this issue and it has great merits, but this is
>>>>>> incomplete.
>>>>>>
>>>>>> DMA_PREP_REPEAT|RELOAD should only imply repeating of transactions=
,
>>>>>> nothing else. I would like to see APIs having explicit behaviour, =
so let
>>>>>> us also add another flag DMA_PREP_LOAD_NEXT|NEW to indicate that t=
he
>>>>>> next transactions will replace the current one when submitted afte=
r calling
>>>>>> .issue_pending().
>>>>>>
>>>>>> Also it makes sense to explicitly specify when the transaction sho=
uld be
>>>>>> reloaded. Rather than make a guesswork based on hardware support, =
we
>>>>>> should specify the EOB/EOT in these flags as well.
>>>>>>
>>>>>> Next is callback notification mechanism and when it should be invo=
ked.
>>>>>> EOT is today indicated by DMA_PREP_INTERRUPT, EOB needs to be adde=
d.
>>>>>>
>>>>>> So to summarize your driver needs to invoke
>>>>>> DMA_PREP_REPEAT|DMA_PREP_LOAD_NEXT|DMA_LOAD_EOT|DMA_PREP_INTERRUPT=

>>>>>> specifying that the transactions are repeated untill next one pops=
 up
>>>>>> and replaced at EOT with callbacks being invoked at EOT boundaries=
=2E
>>>
>>> Peter, what do you think ?
>>
>> Well, I'm in between ;)
>>
>> You have a dedicated DMA which can do one thing - to service display.
>> DMAengine provides generic API for DMA use users.
>>
>> The DMA_PREP_REPEAT is a new flag for a descriptor, imho it can be
>> introduced without breaking anything which exists today.
>>
>> DMA_PREP_REPEAT - the descriptor should be repeated until the channel =
is
>> terminated with terminate_all.
>=20
> No concern about DMA_PREP_REPEAT, I like the idea.
>=20
>> DMA_PREP_LOAD_EOT - the descriptor should be loaded at the next EOT of=

>> the currently running transfer, if any, otherwise start.
>=20
> Why is this needed ? Why can't this be the default behaviour ? What the=

> use case for queuing a descriptor with DMA_PREP_REPEAT and *not* settin=
g
> DMA_PREP_LOAD_EOT on the next one ? If a client queues the next
> descriptor without DMA_PREP_LOAD_EOT, the DMA engine will keep repeatin=
g
> the previous one, the client will hang forever waiting for the switch t=
o
> the new descriptor that will never happen, and no error message or othe=
r
> diagnostic information will be provided. This creates an API that as no=

> purpose (or at least no specified purpose, if there's an actual use cas=
e
> for not specifying that flag, I'm willing to discuss it) and makes it
> easy to shoot oneself in the foot. A good API should be impossible to
> misuse (this can of course not always be achieved in practice, but it's=

> still a good goal to aim for).

If no DMA_PRP_LOAD_EOT is set then yes, the running transfer will not
move towards, like how the cyclic is working.
and...

> And this doesn't even mention DMA_PREP_LOAD_NEXT, that seems equally
> design as a way to maximize chances that drivers will get something
> wrong :-)
>=20
>> DMA_PREP_INTERRUPT - as it is today. Callback at EOT (for
>> slave_sg/interleaved/memcpy/etc, cyclic interprets this differently -
>> callback at period elapse time).
>>
>> So you would set DMA_PREP_REPEAT | DMA_PREP_LOAD_EOT (|
>> DMA_PREP_INTERRUPT if you need callbacks at EOT).
>>
>> The capabilities of the device/channel should tell the user if it is
>> capable of REPEAT and LOAD_EOT.
>> It is possible that a DMA can do repeat, but lacks the ability to do a=
ny
>> type of LOAD_*
>=20
> This is the kind of information I was looking for, thanks. I agree that=

> some DMA engines may not be able to replace a repeated transfer (I'm
> using the word repeated here instead of cyclic, to avoid confusion with=

> the existing cyclic transfer type) at EOT. I however assume they would
> all have the ability to replace it immediately, as DMA engines are
> required to implement terminate_all(), and replacing a transfer
> immediately can then just be a combination of terminate_all() + startin=
g
> the next transfer. Whether we want DMA engines to implement this
> internally instead of having the logical on the client side (as done
> today) is another question, and I'm not pushing in one direction or
> another here (although I think we could explore the option of
> implementing this in the DMA engine core).
>=20
> Having a capability flag to report if a DMA engine supports replacing a=

> repeated transfer at EOT makes sense (no idea if we will have DMA
> engines supporting DMA_REPEAT but not DMA_LOAD_EOT, but that's another
> story, at least in theory it could happen). I hwoever don't see what a
> DMA_PREP_LOAD_EOT flag is needed, if this feature isn't supported,
> shouldn't tx_submit() and/or issue_pending() fail when a repeated
> transfer is queued ? Succeeding in tx_submit() and issue_pending() and
> doing nothing with the newly queued transfers is, as I explained above,=

> a very good way to increase the chance of bugs. I don't see a reason wh=
y
> accepting a call that we know will not perform what the caller expects
> it to perform whould be a good idea.

I would argue that the DMA_PREP_RELOAD_NOW (ASAP?) is a bit more than
terminate_all+issue_pending.

But, DMA drivers might support neither of them, either of them or both.
It is up to the client to pick the preferred method for it's use.
It is not far fetched that the next DMA the client is going to be
serviced will have different capabilities and the client needs to handle
EOT or NOW or it might even need to have fallback to case when neither
is supported.

I don't like excessive flags either, but based on my experience
under-flagging can bite back sooner than later.

I'm aware that at the moment it feels like it is too explicit, but never
underestimate the creativity of the design - and in some cases the
constraint the design must fulfill.

>=20
>> I think this would give a nice starting point to extend on later.
>>
>>>>> Are you *serious* ? I feel trapped in a cross-over of Groundhog Day=
 and
>>>>> Brazil.
>>>>
>>>> Sorry, I don't understand that reference!
>>>>
>>>> Nevertheless, you want a behaviour which is somehow defined by your =
use
>>>> and magically implies certain conditions. I do not want it that way.=

>>>> I would rather see all the flag required.
>>>>
>>>>>> @Peter, did I miss anything else in this..? Please send the patch =
for
>>>>>> this (to start with just the headers so that Laurent can start
>>>>>> using them) and detailed patch with documentation as follow up, I =
trust
>>>>>> you two can coordinate :)
>>>>>
>>>>> I won't call that coordination, no. If you want to design something=

>>>>> absurd that's your call, not mine, I don't want to get involved.
>>>>
>>>> Your wish!
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------AED669D0BE743787B7469DAE
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFki4nsBCAD3BM+Ogt951JlaDloruEjoZk/Z+/37CjP0fY2mqLhBOzkpx95u
X1Fquf0KfVk+ZzCd25XGOZEtpZNlXfbxRr2iRWPS5RW2FeLYGvg2TTJCpSr+ugKu
OOec6KECCUotGbGhpYwBrbarJNEwDcAzPK7UJYa1rhWOmkpZJ1hXF1hUghB84q35
8DmN4sGLcsIbVdRFZ1tWFh4vGBFV9LsoDZIrnnANb6/XMX78s+tr3RG3GZBaFPl8
jO5IIv0UIGNUKaYlNVFYthjGCzOqtstHchWuK9eQkR7m1+Vc+ezh1qK0VJydIcjn
OtoMZZL7RAz13LB9vmcJjbQPnI7dJojz/M7zABEBAAG0JlBldGVyIFVqZmFsdXNp
IDxwZXRlci51amZhbHVzaUB0aS5jb20+iQFOBBMBCAA4FiEE+dBcpRFvJjZw+uta
LCayis85LN4FAlki4nsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQLCay
is85LN4QjggAzxxxXqiWpA3vuj9yrlGLft3BeGKWqF8+RzdeRvshtNdpGeIFf+r5
AJVR71R1w89Qeb4DGXus7qsKiafdFGG7yxbuhw8a5wUm+ZncBXA+ETn3OyVtl8g8
r/ZcPX420jClBNTVuL0sSnyqDFDrt5f+uAFOIwsnHdpns174Zu9QhgYxdvdZ+jMh
Psb745O9EVeNvdfUIRdrVjb4IhJKNIzkb0Tulsz5xeCJReUYpxZU1jzEq3YZqIou
+fi+oS4wlJuSoxKKTmIXtSeEy/weStF1XHMo6vLYqzaK4FyIuclqeuYUYSVy2425
7TMXugaI+O85AEI6KW8MCcu1NucSfAWUabkBDQRZIuJ7AQgAypKq8iIugpHxWA2c
Ck6MQdPBT6cOEVK0tjeHaHAVOUPiw9Pq+ssMifdIkDdqXNZ3RLH/X2svYvd8c81C
egqshfB8nkJ5EKmQc9d7s0EwnYT8OwsoVb3c2WXnsdcKEyu2nHgyeJEUpPpMPyLc
+PWhoREifttab4sOPktepdnUbvrDK/gkjHmiG6+L2owSn637N+Apo3/eQuDajfEu
kybxK19ReRcp6dbqWSBGSeNB32c/zv1ka37bTMNVUY39Rl+/8lA/utLfrMeACHRO
FGO1BexMASKUdmlB0v9n4BaJFGrAJYAFJBNHLCDemqkU7gjaiimuHSjwuP0Wk7Ct
KQJfVQARAQABiQE2BBgBCAAgFiEE+dBcpRFvJjZw+utaLCayis85LN4FAlki4nsC
GwwACgkQLCayis85LN7kCwgAoy9r3ZQfJNOXO1q/YQfpEELHn0p8LpwliSDUS1xL
sswyxtZS8LlW8PjlTXuBLu38Vfr0vGav7oyV7TkhnKT3oBOLXanyZqwgyZSKNEGB
PB4v3Fo7YTzpfSofiwuz03uyfjTxiMGjonxSb+YxM7HBHfzjrOKKlg02fK+lWNZo
m5lXugeWD7U6JJguNdYfr+U4zYIblelUImcIE+wnR0oLzUEVDIWSpVrl/OqS3Rzo
mw8wBsHksTHrbgUnKL0SCzYc90BTeKbyjEBnVDr+dlfbxRxkB8h9RMPMdjodvXzS
Gfsa9V/k4XAsh7iX9EUVBbnmjA61ySxU/w98h96jMuteTg=3D=3D
=3DeQmw
-----END PGP PUBLIC KEY BLOCK-----

--------------AED669D0BE743787B7469DAE--
