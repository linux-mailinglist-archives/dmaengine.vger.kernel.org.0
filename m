Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC691D7A7E
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgERN4i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 09:56:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41556 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgERN4i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 May 2020 09:56:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04IDuXls098303;
        Mon, 18 May 2020 08:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589810193;
        bh=YDiia8JV11fncmTofWcuiRNRiXqz+V6qiq9Wawm38uI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ixRZNbRme0jfENGidElbFEY8KtOnGrIZRuSSrgrA63NLCpIm9xoh+EajgQ1j5IH+o
         7hhCjMwozKVM+SM25QFhqfx9YR6+wmTtXMBbumnQhXD0ArkrwB5LafE7/PvjjFr6rx
         P+waULQ9SxPi3bRSGlJFY61a9DM5un1mevygKsys=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04IDuXNa009477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 08:56:33 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 08:56:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 08:56:33 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04IDuVEu020519;
        Mon, 18 May 2020 08:56:31 -0500
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
Date:   Mon, 18 May 2020 16:57:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515141101.GA7186@pendragon.ideasonboard.com>
Content-Type: multipart/mixed;
        boundary="------------80641228E52FBEE8C45C462C"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------80641228E52FBEE8C45C462C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent, Vinod,

On 15/05/2020 17.11, Laurent Pinchart wrote:
> On Fri, May 15, 2020 at 02:08:17PM +0530, Vinod Koul wrote:
>> Hi Laurent,
>>
>> On 14-05-20, 23:07, Laurent Pinchart wrote:
>>> On Thu, May 14, 2020 at 11:53:44PM +0530, Vinod Koul wrote:
>>>> On 13-05-20, 19:59, Laurent Pinchart wrote:
>>>>> DMA engines used with displays perform 2D interleaved transfers to =
read
>>>>> framebuffers from memory and feed the data to the display engine. A=
s the
>>>>> same framebuffer can be displayed for multiple frames, the DMA
>>>>> transactions need to be repeated until a new framebuffer replaces t=
he
>>>>> current one. This feature is implemented natively by some DMA engin=
es
>>>>> that have the ability to repeat transactions and switch to a new
>>>>> transaction at the end of a transfer without any race condition or =
frame
>>>>> loss.
>>>>>
>>>>> This patch implements support for this feature in the DMA engine AP=
I. A
>>>>> new DMA_PREP_REPEAT transaction flag allows DMA clients to instruct=
 the
>>>>> DMA channel to repeat the transaction automatically until one or mo=
re
>>>>> new transactions are issued on the channel (or until all active DMA=

>>>>> transfers are explicitly terminated with the dmaengine_terminate_*(=
)
>>>>> functions). A new DMA_REPEAT transaction type is also added for DMA=

>>>>> engine drivers to report their support of the DMA_PREP_REPEAT flag.=

>>>>>
>>>>> The DMA_PREP_REPEAT flag is currently supported for interleaved
>>>>> transactions only. Its usage can easily be extended to cover more
>>>>> transaction types simply by adding an appropriate check in the
>>>>> corresponding dmaengine_prep_*() function.
>>>>>
>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>=

>>>>> ---
>>>>> If this approach is accepted I can send a new version that updates
>>>>> documentation in Documentation/driver-api/dmaengine/, and extend su=
pport
>>>>> of DMA_PREP_REPEAT to the other transaction types, if desired alrea=
dy.
>>>>>
>>>>>  include/linux/dmaengine.h | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>>>> index 64461fc64e1b..9fa00bdbf583 100644
>>>>> --- a/include/linux/dmaengine.h
>>>>> +++ b/include/linux/dmaengine.h
>>>>> @@ -61,6 +61,7 @@ enum dma_transaction_type {
>>>>>  	DMA_SLAVE,
>>>>>  	DMA_CYCLIC,
>>>>>  	DMA_INTERLEAVE,
>>>>> +	DMA_REPEAT,
>>>>>  /* last transaction type for creation of the capabilities mask */
>>>>>  	DMA_TX_TYPE_END,
>>>>>  };
>>>>> @@ -176,6 +177,11 @@ struct dma_interleaved_template {
>>>>>   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API =
is command
>>>>>   *  data and the descriptor should be in different format from nor=
mal
>>>>>   *  data descriptors.
>>>>> + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be=
 automatically
>>>>> + *  repeated when it ends if no other transaction has been issued =
on the same
>>>>> + *  channel. If other transactions have been issued, this transact=
ion completes
>>>>> + *  normally. This flag is only applicable to interleaved transact=
ions and is
>>>>> + *  ignored for all other transaction types.

It should not be restricted to interleaved, slave_sg/memcpy/etc can be
repeated if the DMA driver implements it (a user on a given platform
needs it).

>>>>>   */
>>>>>  enum dma_ctrl_flags {
>>>>>  	DMA_PREP_INTERRUPT =3D (1 << 0),
>>>>> @@ -186,6 +192,7 @@ enum dma_ctrl_flags {
>>>>>  	DMA_PREP_FENCE =3D (1 << 5),
>>>>>  	DMA_CTRL_REUSE =3D (1 << 6),
>>>>>  	DMA_PREP_CMD =3D (1 << 7),
>>>>> +	DMA_PREP_REPEAT =3D (1 << 8),
>>>>
>>>> Thanks for sending this. I think this is a good proposal which Peter=

>>>> made for solving this issue and it has great merits, but this is
>>>> incomplete.
>>>>
>>>> DMA_PREP_REPEAT|RELOAD should only imply repeating of transactions,
>>>> nothing else. I would like to see APIs having explicit behaviour, so=
 let
>>>> us also add another flag DMA_PREP_LOAD_NEXT|NEW to indicate that the=

>>>> next transactions will replace the current one when submitted after =
calling
>>>> .issue_pending().
>>>>
>>>> Also it makes sense to explicitly specify when the transaction shoul=
d be
>>>> reloaded. Rather than make a guesswork based on hardware support, we=

>>>> should specify the EOB/EOT in these flags as well.
>>>>
>>>> Next is callback notification mechanism and when it should be invoke=
d.
>>>> EOT is today indicated by DMA_PREP_INTERRUPT, EOB needs to be added.=

>>>>
>>>> So to summarize your driver needs to invoke
>>>> DMA_PREP_REPEAT|DMA_PREP_LOAD_NEXT|DMA_LOAD_EOT|DMA_PREP_INTERRUPT
>>>> specifying that the transactions are repeated untill next one pops u=
p
>>>> and replaced at EOT with callbacks being invoked at EOT boundaries.
>=20
> Peter, what do you think ?

Well, I'm in between ;)

You have a dedicated DMA which can do one thing - to service display.
DMAengine provides generic API for DMA use users.

The DMA_PREP_REPEAT is a new flag for a descriptor, imho it can be
introduced without breaking anything which exists today.

DMA_PREP_REPEAT - the descriptor should be repeated until the channel is
terminated with terminate_all.

DMA_PREP_LOAD_EOT - the descriptor should be loaded at the next EOT of
the currently running transfer, if any, otherwise start.

DMA_PREP_INTERRUPT - as it is today. Callback at EOT (for
slave_sg/interleaved/memcpy/etc, cyclic interprets this differently -
callback at period elapse time).

So you would set DMA_PREP_REPEAT | DMA_PREP_LOAD_EOT (|
DMA_PREP_INTERRUPT if you need callbacks at EOT).

The capabilities of the device/channel should tell the user if it is
capable of REPEAT and LOAD_EOT.
It is possible that a DMA can do repeat, but lacks the ability to do any
type of LOAD_*

I think this would give a nice starting point to extend on later.

- P=C3=A9ter

>>> Are you *serious* ? I feel trapped in a cross-over of Groundhog Day a=
nd
>>> Brazil.
>>
>> Sorry, I don't understand that reference!
>>
>> Nevertheless, you want a behaviour which is somehow defined by your us=
e
>> and magically implies certain conditions. I do not want it that way.
>> I would rather see all the flag required.
>>
>>>> @Peter, did I miss anything else in this..? Please send the patch fo=
r
>>>> this (to start with just the headers so that Laurent can start
>>>> using them) and detailed patch with documentation as follow up, I tr=
ust
>>>> you two can coordinate :)
>>>
>>> I won't call that coordination, no. If you want to design something
>>> absurd that's your call, not mine, I don't want to get involved.
>>
>> Your wish!
>=20

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------80641228E52FBEE8C45C462C
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

--------------80641228E52FBEE8C45C462C--
