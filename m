Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35E71ECDCE
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFCKuc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 06:50:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46228 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCKub (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 06:50:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 053AoQFm045272;
        Wed, 3 Jun 2020 05:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591181426;
        bh=TiVCOp709YcsjGuUWwkymuPMKR4kk7kp7KafVJPZxlI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ldrgrAvDdcI3v6YarR2imN9ZAXFS9N89eHJr83Em4zZcBQcnDYyTIRNPkhOrambb4
         hS7np10OvTRBWDAVRFqFVnAs8HLGCraCkER7/2MNlDOSLC94bhyiyOSxs8dAf5qeXR
         unqFhGI2pAl1i1pMtEn17v323lZORf302361rElI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 053AoPV9109130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Jun 2020 05:50:26 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Jun
 2020 05:50:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Jun 2020 05:50:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 053AoNHg095201;
        Wed, 3 Jun 2020 05:50:24 -0500
Subject: Re: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
References: <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
 <20200514182344.GI14092@vkoul-mobl>
 <20200514200709.GL5955@pendragon.ideasonboard.com>
 <20200515083817.GP333670@vkoul-mobl>
 <20200515141101.GA7186@pendragon.ideasonboard.com>
 <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
 <20200518143208.GD5851@pendragon.ideasonboard.com>
 <872d2f33-cdea-34c3-38b4-601d6dae7c94@ti.com>
 <20200528021006.GG4670@pendragon.ideasonboard.com>
 <23b26252-eb7b-f918-759d-0ccda90586b0@ti.com>
 <20200601114937.GC5886@pendragon.ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <00b39de6-58e5-b86b-8d20-e0451be45b15@ti.com>
Date:   Wed, 3 Jun 2020 13:51:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601114937.GC5886@pendragon.ideasonboard.com>
Content-Type: multipart/mixed;
        boundary="------------7619E07F09B757501AEC3CBD"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------7619E07F09B757501AEC3CBD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 01/06/2020 14.49, Laurent Pinchart wrote:
> Hi Peter,
>=20
> On Mon, Jun 01, 2020 at 02:14:03PM +0300, Peter Ujfalusi wrote:
>> On 28/05/2020 5.10, Laurent Pinchart wrote:
>>>>> As mentioned in the commit message, I plan to extend that, I just d=
idn't
>>>>> want to add the checks to all the prepare operation wrappers until =
an
>>>>> agreement on the approach would be reached. I also thought it would=
 be
>>>>> good to not allow this API for other transaction types until use ca=
ses
>>>>> arise, in order to force upstream discussions instead of silently
>>>>> abusing the API :-)
>>>>
>>>> I would not object if slave_sg and memcpy got the same treatment. If=
 the
>>>> DMA driver did not set the DMA_REPEAT then clients can not use this
>>>> feature anyways.
>>>
>>> Would you not object, or would you prefer if it was done in v5 ? :-)
>>
>> DMA_REPEAT is a generic flag, not limited to only interleaved, but you=

>> are going to be the first user of it with interleaved.
>>
>>> Overall I think that enabling APIs that have no user isn't necessaril=
y
>>> the best idea, as it's prone to design issues, but I don't mind doing=
 so
>>> if you think it needs to be done now.
>>
>> We would get the support in one go with the same commit. I don't think=

>> it makes much sense to add slave_sg later, then memcpy another time.
>> True, there might be no users for them for some time, but their presen=
ts
>> might invite users?
>=20
> My approach to API design is that an API designed without (at least) on=
e
> user is very prone to be a bad API. As I said before I don't mind
> enabling support for slave_sg and memcpy today already, even if I don't=

> think it's a good idea. I want to get my use case supported, and I've
> given up on what I would consider a good API :-) That's fine,
> maintainers are the ones who have to support APIs and the design choice=
s
> behind them in the longer term, and I'm not a subsystem maintainer here=
=2E
> I tried to prevent what I think may become a case of shooting in the
> foot, but I could be wrong. Only the future will tell.

Yes, we will see in the longer run.

>>>>> I can extend the flag to all other transaction types
>>>>> (except for the cyclic transaction, as it doesn't make sense there)=
=2E
>>>>
>>>> Yep, cyclic is a different type of transfer, it is for circular buff=
ers.
>>>> It could be seen as a special case of slave_sg. Some drivers actuall=
y
>>>> create temporary sg_list in case of cyclic and use the same setup
>>>> function to set up the transfer for slave_sg/cyclic...
>>>
>>> Cyclic is different for historical reasons, but if I had to redesign =
it
>>> today, I'd make it slave_sg + DMA_PREP_REPEAT. We obviously can't, an=
d I
>>> have no issue with that.
>>
>> Which should be accompanied with a flag to tell that the sg_list is
>> covering a circular buffer to save all drivers to check the sg_list th=
at
>> it is circular buffer (current cyclic) or really sg.
>> Some DMA can only do repeat on circular buffers (omap-dma, tegra, etc)=
=2E
>=20
> Isn't DMA_PREP_REPEAT that flag ?

Not really. It tells that the descriptor should be repeated. In case of
slave_sg the list could describe one block of memory, split up to
'periods' or it could be a list scattered chunks all over the place.

circular buffer can be described with sg_list.
sg_list is not necessary describes a circular buffer.

>>>> But, DMA drivers might support neither of them, either of them or bo=
th.
>>>> It is up to the client to pick the preferred method for it's use.
>>>> It is not far fetched that the next DMA the client is going to be
>>>> serviced will have different capabilities and the client needs to ha=
ndle
>>>> EOT or NOW or it might even need to have fallback to case when neith=
er
>>>> is supported.
>>>>
>>>> I don't like excessive flags either, but based on my experience
>>>> under-flagging can bite back sooner than later.
>>>>
>>>> I'm aware that at the moment it feels like it is too explicit, but n=
ever
>>>> underestimate the creativity of the design - and in some cases the
>>>> constraint the design must fulfill.
>>>
>>> I'm still very puzzled by why you think adding DMA_PREP_LOAD_EOT now =
is
>>> a good idea, given that there's no existing and no foreseen use case =
for
>>> not setting it. Creating an API element that is completely disconnect=
ed
>>> from any known use case doesn't seem like good API design to me,
>>> especially for an in-kernel API.
>>
>> If we document that DMA_REPEAT covers REPEAT _and_ LOAD_EOT with one
>> flag then how would other drivers can implement REPEAT if they can not=

>> support LOAD_EOT?
>> They should do DMA_REPEAT | NOT_LOAD_EOT | LOAD_ASAP?
>=20
> As stated before, I think a DMA_LOAD_EOT capability is useful. My
> concern is about DMA_PREP_LOAD_EOT for which I can't see use cases. I'v=
e
> added DMA_PREP_LOAD_EOT in the last patch series, and my DMA engine
> driver ignores the transaction when DMA_PREP_LOAD_EOT is not set, as
> required. It works fine as the my client always sets it.

Thanks.

> I'd expect Vinod or you to write the documentation though, as writing
> code for an API I don't believe in is one thing, writing documentation
> to explain the rationale behind the API design will be more complex

Vinod can correct me, but for the capabilities:
DMA_REPEAT: the controller (and driver) supports repeating the
	descriptor. It can be terminated with terminate_all
DMA_LOAD_EOT: the controller (and driver) supports loading the next
	issued transfer on a channel which is running DMA_REPEAT
	descriptor. Iow, instead of reloading the running transfer, it
	moves to the next one.
DMA_LOAD_NOW: the controller (and driver) supports aborting the
	active descriptor (either DMA_REPEAT or non repeated one) and
	moving to the next issued transfer without clients needing to
	use terminate_all.

> when I don't believe there's any rationale :-)

Sure, you have a specific DMA, which does one thing and one thing only.
When a subsystem decides to create a generic DMA layer on top of
DMAengine for example to get rid of the duplicated code in the drivers
then this generic code does need information to decide how the servicing
DMA should be used for optimal performance and quality.
Some DMAs (and drivers) might have slightly different capabilities.

>> LOAD_EOT is a feature the HW can or can not support and it is an
>> operation mode that you want to use or do not want to use.
>=20
> DMA_PREP_REPEAT for the EOT mode, DRM_PREP_REPEAT | DMA_PREP_LOAD_NOW
> for the immediate mode would work too, and wouldn't have the drawback o=
f
> artificially creating a case (!EOT && !NOW) that would fail.

But if a DMA does not support LOAD_EOT at all? If it did not support
LOAD_NOW either?
But if anything the LOAD_NOW sounds more of a default expectation than
LOAD_EOT.
Yes, I know. The display use case needs LOAD_EOT to avoid artifacts on
screen, but DMA_REPEAT is not only for displays.

> I'm tired of arguing about this and trying to prevent mistakes from
> being made, so could you please review the latest patch series, and tel=
l
> me if there's anything missing for the implementation ? Feel free to
> provide that feedback as patches on top.
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------7619E07F09B757501AEC3CBD
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

--------------7619E07F09B757501AEC3CBD--
