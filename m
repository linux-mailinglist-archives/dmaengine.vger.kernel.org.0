Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847E7B8134
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjJDNmo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjJDNmn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 09:42:43 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786ACA1;
        Wed,  4 Oct 2023 06:42:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1696426375; bh=wNjKzyyTmdOg7uQ8lHsJwP6npxIRpn3RBhKr/25m9kE=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=P0KQ+jKZP8N1aYWyEuaU5w+p9z+ayZ86Y2burNJLk57FxpgOQKPATezdPJfyrI5H5
         zAHmn0UaRkega9ktsWRFFuhJbsuFVLBoDW2SHCvAymBbI0BhDDconlYcMhOiYtLDLF
         +nV3dto+0g4RnwNuIMFPXQP2jQtGeQZNC5seb1TM=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 2/2] dmaengine: apple-sio: Add Apple SIO driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <ZR1kz7Sil8onc1uC@matsya>
Date:   Wed, 4 Oct 2023 15:32:44 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06444557-414A-4710-88A0-620975BB258A@cutebit.org>
References: <20230828170013.75820-1-povik+lin@cutebit.org>
 <20230828170013.75820-3-povik+lin@cutebit.org> <ZR1kz7Sil8onc1uC@matsya>
To:     Vinod Koul <vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hello Vinod,

some of those things we have discussed on v1 already, let me link
that here:
=
https://lore.kernel.org/asahi/20230712133806.4450-1-povik+lin@cutebit.org/=
T/#t

Anyway find my replies below.

Best regards, Martin

> On 4. 10. 2023, at 15:12, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 28-08-23, 19:00, Martin Povi=C5=A1er wrote:
>> Add a dmaengine driver for the Apple SIO coprocessor found on Apple
>> SoCs where it provides DMA services. Have the driver support cyclic
>> transactions so that ALSA drivers can rely on it in audio output to
>> HDMI and DisplayPort.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> MAINTAINERS             |   2 +
>> drivers/dma/Kconfig     |  11 +
>> drivers/dma/Makefile    |   1 +
>> drivers/dma/apple-sio.c | 868 =
++++++++++++++++++++++++++++++++++++++++
>> 4 files changed, 882 insertions(+)
>> create mode 100644 drivers/dma/apple-sio.c
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3be1bdfe8ecc..e65cf3d535ef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1865,7 +1865,9 @@ M: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> L: asahi@lists.linux.dev
>> L: alsa-devel@alsa-project.org (moderated for non-subscribers)
>> S: Maintained
>> +F: Documentation/devicetree/bindings/dma/apple,sio.yaml
>> F: Documentation/devicetree/bindings/sound/apple,*
>> +F: drivers/dma/apple-sio.c
>> F: sound/soc/apple/*
>> F: sound/soc/codecs/cs42l83-i2c.c
>>=20
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index f52d36e713f3..6e385dee2d3d 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -89,10 +89,21 @@ config APPLE_ADMAC
>> tristate "Apple ADMAC support"
>> depends on ARCH_APPLE || COMPILE_TEST
>> select DMA_ENGINE
>> + select DMA_VIRTUAL_CHANNELS
>> default ARCH_APPLE
>> help
>>   Enable support for Audio DMA Controller found on Apple Silicon =
SoCs.
>>=20
>> +config APPLE_SIO
>> + tristate "Apple SIO support"
>> + depends on ARCH_APPLE || COMPILE_TEST
>> + depends on APPLE_RTKIT
>> + select DMA_ENGINE
>> + default ARCH_APPLE
>> + help
>> +   Enable support for the SIO coprocessor found on Apple Silicon =
SoCs
>> +   where it provides DMA services.
>> +
>> config AT_HDMAC
>> tristate "Atmel AHB DMA support"
>> depends on ARCH_AT91
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 83553a97a010..787583ff2d45 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_AMBA_PL08X) +=3D amba-pl08x.o
>> obj-$(CONFIG_AMCC_PPC440SPE_ADMA) +=3D ppc4xx/
>> obj-$(CONFIG_AMD_PTDMA) +=3D ptdma/
>> obj-$(CONFIG_APPLE_ADMAC) +=3D apple-admac.o
>> +obj-$(CONFIG_APPLE_SIO) +=3D apple-sio.o
>> obj-$(CONFIG_AT_HDMAC) +=3D at_hdmac.o
>> obj-$(CONFIG_AT_XDMAC) +=3D at_xdmac.o
>> obj-$(CONFIG_AXI_DMAC) +=3D dma-axi-dmac.o
>> diff --git a/drivers/dma/apple-sio.c b/drivers/dma/apple-sio.c
>> new file mode 100644
>> index 000000000000..e15deeded4dc
>> --- /dev/null
>> +++ b/drivers/dma/apple-sio.c
>> @@ -0,0 +1,868 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/*
>> + * Driver for SIO coprocessor on t8103 (M1) and other Apple SoCs
>> + *
>> + * Copyright (C) The Asahi Linux Contributors
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/completion.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/soc/apple/rtkit.h>
>> +
>> +#include "dmaengine.h"
>> +#include "virt-dma.h"
>> +
>> +#define NCHANNELS_MAX 0x80
>> +
>> +#define REG_CPU_CONTROL 0x44
>> +#define CPU_CONTROL_RUN BIT(4)
>> +
>> +#define SIOMSG_DATA GENMASK(63, 32)
>> +#define SIOMSG_TYPE GENMASK(23, 16)
>> +#define SIOMSG_PARAM GENMASK(31, 24)
>> +#define SIOMSG_TAG GENMASK(13, 8)
>> +#define SIOMSG_EP GENMASK(7, 0)
>> +
>> +#define EP_SIO 0x20
>> +
>> +#define MSG_START 0x2
>> +#define MSG_SETUP 0x3
>> +#define MSG_CONFIGURE 0x5
>> +#define MSG_ISSUE 0x6
>> +#define MSG_TERMINATE 0x8
>> +#define MSG_ACK 0x65
>> +#define MSG_NACK 0x66
>> +#define MSG_STARTED 0x67
>> +#define MSG_REPORT 0x68
>> +
>> +#define SIO_CALL_TIMEOUT_MS 100
>> +#define SIO_SHMEM_SIZE 0x1000
>> +#define SIO_NO_DESC_SLOTS 64
>> +
>> +/*
>> + * There are two kinds of 'transaction descriptors' in play here.
>> + *
>> + * There's the struct sio_tx, and the struct dma_async_tx_descriptor =
embedded
>> + * inside, which jointly represent a transaction to the dmaengine =
subsystem.
>> + * At this time we only support those transactions to be cyclic.
>> + *
>> + * Then there are the coprocessor descriptors, which is what the =
coprocessor
>> + * knows and understands. These don't seem to have a cyclic regime, =
so we can't
>> + * map the dmaengine transaction on an exact coprocessor =
counterpart. Instead
>> + * we continually queue up many coprocessor descriptors to implement =
a cyclic
>> + * transaction.
>> + *
>> + * The number below is the maximum of how far ahead (how many) =
coprocessor
>> + * descriptors we should be queuing up, per channel, for a cyclic =
transaction.
>> + * Basically it's a made-up number.
>> + */
>> +#define SIO_MAX_NINFLIGHT 4
>=20
> you meant SIO_MAX_INFLIGHT if not what is NINFLIGHT?

I mean the number is arbitrary, it doesn=E2=80=99t reflect any =
coprocessor limit since
I haven=E2=80=99t run the tests to figure one out. It's supposed to be a =
small reasonable
number.

>> +struct sio_coproc_desc {
>> + u32 pad1;
>> + u32 flag;
>> + u64 unk;
>> + u64 iova;
>> + u64 size;
>> + u64 pad2;
>> + u64 pad3;
>> +} __packed;
>> +static_assert(sizeof(struct sio_coproc_desc) =3D=3D 48);
>> +
>> +struct sio_shmem_chan_config {
>> + u32 datashape;
>> + u32 timeout;
>> + u32 fifo;
>> + u32 threshold;
>> + u32 limit;
>> +} __packed;
>> +
>> +struct sio_data;
>> +struct sio_tx;
>> +
>> +struct sio_chan {
>> + unsigned int no;
>> + struct sio_data *host;
>> + struct virt_dma_chan vc;
>> + struct work_struct terminate_wq;
>> +
>> + struct sio_tx *current_tx;
>> +};
>> +
>> +#define SIO_NTAGS 16
>> +
>> +typedef void (*sio_ack_callback)(struct sio_chan *, void *, bool);
>=20
> what is this callback used for?

This one is used to signal completion of IPC calls made to the =
coprocessor
from atomic contexts, so when we can=E2=80=99t do a blocking wait on the =
coprocessor=E2=80=99s
response. The only user (currently) is issuing of coproc descriptors.

>=20
>> +
>> +struct sio_data {
>> + void __iomem *base;
>> + struct dma_device dma;
>> + struct device *dev;
>> + struct apple_rtkit *rtk;
>> + void *shmem;
>> + struct sio_coproc_desc *shmem_desc_base;
>> + unsigned long *desc_allocated;
>> +
>> + struct sio_tagdata {
>> + DECLARE_BITMAP(allocated, SIO_NTAGS);
>> + int last_tag;
>> +
>> + struct completion completions[SIO_NTAGS];
>> + bool atomic[SIO_NTAGS];
>> + bool acked[SIO_NTAGS];
>> +
>> + sio_ack_callback ack_callback[SIO_NTAGS];
>> + void *cookie[SIO_NTAGS];
>> + } tags;
>> +
>> + int nchannels;
>> + struct sio_chan channels[];
>> +};
>> +
>> +struct sio_tx {
>> + struct virt_dma_desc vd;
>> + struct completion done;
>> +
>> + bool terminated;
>> + size_t period_len;
>> + int nperiods;
>> + int ninflight;
>> + int next;
>> +
>> + struct sio_coproc_desc *siodesc[];
>> +};
>> +
>> +static int sio_send_siomsg(struct sio_data *sio, u64 msg);
>> +static int sio_send_siomsg_atomic(struct sio_data *sio, u64 msg,
>> +   sio_ack_callback ack_callback,
>> +   void *cookie);
>> +static int sio_call(struct sio_data *sio, u64 msg);
>> +
>> +static struct sio_chan *to_sio_chan(struct dma_chan *chan)
>> +{
>> + return container_of(chan, struct sio_chan, vc.chan);
>> +}
>> +
>> +static struct sio_tx *to_sio_tx(struct dma_async_tx_descriptor *tx)
>> +{
>> + return container_of(tx, struct sio_tx, vd.tx);
>> +}
>> +
>> +static int sio_alloc_tag(struct sio_data *sio)
>> +{
>> + struct sio_tagdata *tags =3D &sio->tags;
>> + int tag, i;
>> +
>> + /*
>> +  * Because tag number 0 is special, the usable tag range
>> +  * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
>> +  * we do modulo (SIO_NTAGS - 1) *then* plus one.
>> +  */
>> +
>> +#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
>> + tag =3D (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
>> +
>> + for (i =3D 0; i < SIO_USABLE_TAGS; i++) {
>> + if (!test_and_set_bit(tag, tags->allocated))
>> + break;
>> +
>> + tag =3D (tag % SIO_USABLE_TAGS) + 1;
>> + }
>> +
>> + WRITE_ONCE(tags->last_tag, tag);
>> +
>> + if (i < SIO_USABLE_TAGS)
>> + return tag;
>> + else
>> + return -EBUSY;
>> +#undef SIO_USABLE_TAGS
>=20
> ida_alloc can be used as well to get a tag as well

We have discussed this a bit on v1. I mentioned ida_alloc is deprecated
so I don=E2=80=99t want to use it, and xarray was assessed too =
heavyweight for
usage here.

>> +}
>> +
>> +static void sio_free_tag(struct sio_data *sio, int tag)
>> +{
>> + struct sio_tagdata *tags =3D &sio->tags;
>> +
>> + if (WARN_ON(tag >=3D SIO_NTAGS))
>> + return;
>> +
>> + tags->atomic[tag] =3D false;
>> + tags->ack_callback[tag] =3D NULL;
>> +
>> + WARN_ON(!test_and_clear_bit(tag, tags->allocated));
>> +}
>> +
>> +static void sio_set_tag_atomic(struct sio_data *sio, int tag,
>> +        sio_ack_callback ack_callback,
>> +        void *cookie)
>> +{
>> + struct sio_tagdata *tags =3D &sio->tags;
>> +
>> + tags->atomic[tag] =3D true;
>> + tags->ack_callback[tag] =3D ack_callback;
>> + tags->cookie[tag] =3D cookie;
>> +}
>> +
>> +static struct sio_coproc_desc *sio_alloc_desc(struct sio_data *sio)
>> +{
>> + int i;
>> +
>> + for (i =3D 0; i < SIO_NO_DESC_SLOTS; i++)
>> + if (!test_and_set_bit(i, sio->desc_allocated))
>> + return sio->shmem_desc_base + i;
>> +
>> + return NULL;
>> +}
>> +
>> +static void sio_free_desc(struct sio_data *sio, struct =
sio_coproc_desc *desc)
>> +{
>> + clear_bit(desc - sio->shmem_desc_base, sio->desc_allocated);
>> +}
>> +
>> +static int sio_coproc_desc_slot(struct sio_data *sio, struct =
sio_coproc_desc *desc)
>> +{
>> + return (desc - sio->shmem_desc_base) * 4;
>> +}
>> +
>> +static enum dma_transfer_direction sio_chan_direction(int channo)
>> +{
>> + /* Channel directions are fixed based on channel number */
>> + return (channo & 1) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
>> +}
>> +
>> +static void sio_tx_free(struct virt_dma_desc *vd)
>> +{
>> + struct sio_data *sio =3D to_sio_chan(vd->tx.chan)->host;
>> + struct sio_tx *siotx =3D to_sio_tx(&vd->tx);
>> + int i;
>> +
>> + for (i =3D 0; i < siotx->nperiods; i++)
>> + if (siotx->siodesc[i])
>> + sio_free_desc(sio, siotx->siodesc[i]);
>> + kfree(siotx);
>> +}
>> +
>> +static struct dma_async_tx_descriptor *sio_prep_dma_cyclic(
>> + struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>> + size_t period_len, enum dma_transfer_direction direction,
>> + unsigned long flags)
>> +{
>> + struct sio_chan *siochan =3D to_sio_chan(chan);
>> + struct sio_tx *siotx =3D NULL;
>> + int i, nperiods =3D buf_len / period_len;
>> +
>> + if (direction !=3D sio_chan_direction(siochan->no))
>> + return NULL;
>> +
>> + siotx =3D kzalloc(struct_size(siotx, siodesc, nperiods), =
GFP_NOWAIT);
>=20
> wasnt there a helper to do this sort of thing...

I don=E2=80=99t see one here.
https://www.kernel.org/doc/html/latest/core-api/mm-api.html

>> + if (!siotx)
>> + return NULL;
>> +
>> + init_completion(&siotx->done);
>> + siotx->period_len =3D period_len;
>> + siotx->nperiods =3D nperiods;
>> +
>> + for (i =3D 0; i < nperiods; i++) {
>> + struct sio_coproc_desc *d;
>> +
>> + siotx->siodesc[i] =3D d =3D sio_alloc_desc(siochan->host);
>> + if (!d) {
>> + sio_tx_free(&siotx->vd);
>> + return NULL;
>> + }
>> +
>> + d->flag =3D 1; // not sure what's up with this
>=20
> :-) but /* comments only */ pls

OK

>> + d->iova =3D buf_addr + period_len * i;
>> + d->size =3D period_len;
>> + }
>> + dma_wmb();
>=20
> why do you need a barrier here

We are writing into memory shared with the coprocessor.

>> +
>> + return vchan_tx_prep(&siochan->vc, &siotx->vd, flags);
>> +}
>> +
>> +static enum dma_status sio_tx_status(struct dma_chan *chan, =
dma_cookie_t cookie,
>> +      struct dma_tx_state *txstate)
>> +{
>> + struct sio_chan *siochan =3D to_sio_chan(chan);
>> + struct virt_dma_desc *vd;
>> + struct sio_tx *siotx;
>> + enum dma_status ret;
>> + unsigned long flags;
>> + int periods_residue;
>> + size_t residue;
>> +
>> + ret =3D dma_cookie_status(chan, cookie, txstate);
>> + if (ret =3D=3D DMA_COMPLETE || !txstate)
>> + return ret;
>> +
>> + spin_lock_irqsave(&siochan->vc.lock, flags);
>> + siotx =3D siochan->current_tx;
>> +
>> + if (siotx && siotx->vd.tx.cookie =3D=3D cookie) {
>> + ret =3D DMA_IN_PROGRESS;
>> + periods_residue =3D siotx->next - siotx->ninflight;
>> + while (periods_residue < 0)
>> + periods_residue +=3D siotx->nperiods;
>> + residue =3D (siotx->nperiods - periods_residue) * =
siotx->period_len;
>> + } else {
>> + ret =3D DMA_IN_PROGRESS;
>> + residue =3D 0;
>> + vd =3D vchan_find_desc(&siochan->vc, cookie);
>> + if (vd) {
>> + siotx =3D to_sio_tx(&vd->tx);
>> + residue =3D siotx->period_len * siotx->nperiods;
>> + }
>> + }
>> + spin_unlock_irqrestore(&siochan->vc.lock, flags);
>> + dma_set_residue(txstate, residue);
>> +
>> + return ret;
>> +}
>> +
>> +static bool sio_fill_in_locked(struct sio_chan *siochan);
>> +
>> +static void sio_handle_issue_ack(struct sio_chan *siochan, void =
*cookie, bool ok)
>> +{
>> + unsigned long flags;
>> + dma_cookie_t tx_cookie =3D (unsigned long) cookie;
>> + struct sio_tx *tx;
>=20
> reverse christmas tree style pls

Oh dear

>> +
>> + if (!ok) {
>> + dev_err(siochan->host->dev, "nacked issue on chan %d\n", =
siochan->no);
>> + return;
>> + }
>> +
>> + spin_lock_irqsave(&siochan->vc.lock, flags);
>> + if (!siochan->current_tx || tx_cookie !=3D =
siochan->current_tx->vd.tx.cookie ||
>> + siochan->current_tx->terminated)
>> + goto out;
>> +
>> + tx =3D siochan->current_tx;
>> + tx->next =3D (tx->next + 1) % tx->nperiods;
>> + tx->ninflight++;
>> + sio_fill_in_locked(siochan);
>> +
>> +out:
>> + spin_unlock_irqrestore(&siochan->vc.lock, flags);
>> +}

...

>> +
>> +static const struct apple_rtkit_ops sio_rtkit_ops =3D {
>> + .crashed =3D sio_rtk_crashed,
>> + .recv_message =3D sio_recv_msg,
>> +};
>=20
> so we ahve a remote processor which we send message to right?=20

Yes

>=20
>> +static int sio_device_config(struct dma_chan *chan,
>> +      struct dma_slave_config *config)
>> +{
>> + struct sio_chan *siochan =3D to_sio_chan(chan);
>> + struct sio_data *sio =3D siochan->host;
>> + bool is_tx =3D sio_chan_direction(siochan->no) =3D=3D =
DMA_MEM_TO_DEV;
>> + struct sio_shmem_chan_config *cfg =3D sio->shmem;
>> + int ret;
>> +
>> + switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
>> + case DMA_SLAVE_BUSWIDTH_1_BYTE:
>> + cfg->datashape =3D 0;
>> + break;
>> + case DMA_SLAVE_BUSWIDTH_2_BYTES:
>> + cfg->datashape =3D 1;
>> + break;
>> + case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> + cfg->datashape =3D 2;
>> + break;
>> + default:
>> + return -EINVAL;
>> + }
>> +
>> + cfg->fifo =3D 0x800;
>> + cfg->limit =3D 0x800;
>> + cfg->threshold =3D 0x800;
>> + dma_wmb();
>=20
> ??

Again, shared memory

>> +
>> + ret =3D sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_CONFIGURE) |
>> +     FIELD_PREP(SIOMSG_EP, siochan->no));
>=20
> this does not sound okay, can you explain why this call is here

We are sending the configuration to the coprocessor, it will NACK
it if invalid, seems very fitting here.

>> +
>> + if (ret =3D=3D 1)
>> + ret =3D 0;
>> + else if (ret =3D=3D 0)
>> + ret =3D -EINVAL;
>> + return ret;
>> +}
>> +
>> +static int sio_alloc_shmem(struct sio_data *sio)
>> +{
>> + dma_addr_t iova;
>> + int err;
>> +
>> + sio->shmem =3D dma_alloc_coherent(sio->dev, SIO_SHMEM_SIZE,
>> + &iova, GFP_KERNEL);
>> + if (!sio->shmem)
>> + return -ENOMEM;
>> +
>> + sio->shmem_desc_base =3D (struct sio_coproc_desc *) (sio->shmem + =
56);
>> + sio->desc_allocated =3D devm_kzalloc(sio->dev, SIO_NO_DESC_SLOTS / =
32,
>> +    GFP_KERNEL);
>> + if (!sio->desc_allocated)
>> + return -ENOMEM;
>> +
>> + err =3D sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_SETUP) |
>> +     FIELD_PREP(SIOMSG_PARAM, 1) |
>> +     FIELD_PREP(SIOMSG_DATA, iova >> 12));
>> + if (err !=3D 1) {
>> + if (err =3D=3D 0)
>> + err =3D -EINVAL;
>> + return err;
>> + }
>> +
>> + err =3D sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_SETUP) |
>> +     FIELD_PREP(SIOMSG_PARAM, 2) |
>> +     FIELD_PREP(SIOMSG_DATA, SIO_SHMEM_SIZE));
>> + if (err !=3D 1) {
>> + if (err =3D=3D 0)
>> + err =3D -EINVAL;
>> + return err;
>> + }
>> +
>> + return 0;
>> +}
>> +
>> +static int sio_send_dt_params(struct sio_data *sio)
>> +{
>> + struct device_node *np =3D sio->dev->of_node;
>> + const char *propname =3D "apple,sio-firmware-params";
>> + int nparams, err, i;
>> +
>> + nparams =3D of_property_count_u32_elems(np, propname);
>> + if (nparams < 0) {
>> + err =3D nparams;
>> + goto badprop;
>> + }
>> +
>> + for (i =3D 0; i < nparams / 2; i++) {
>> + u32 key, val;
>> +
>> + err =3D of_property_read_u32_index(np, propname, 2 * i, &key);
>> + if (err)
>> + goto badprop;
>> + err =3D of_property_read_u32_index(np, propname, 2 * i + 1, &val);
>> + if (err)
>> + goto badprop;
>> +
>> + err =3D sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_SETUP) |
>> +     FIELD_PREP(SIOMSG_PARAM, key & 0xff) |
>> +     FIELD_PREP(SIOMSG_EP, key >> 8) |
>> +     FIELD_PREP(SIOMSG_DATA, val));
>> + if (err < 1) {
>> + if (err =3D=3D 0)
>> + err =3D -ENXIO;
>> + return dev_err_probe(sio->dev, err, "sending SIO parameter %#x =
value %#x\n",
>> +      key, val);
>> + }
>> + }
>> +
>> + return 0;
>> +
>> +badprop:
>> + return dev_err_probe(sio->dev, err, "failed to read '%s'\n", =
propname);
>> +}
>> +
>> +static int sio_probe(struct platform_device *pdev)
>> +{
>> + struct device_node *np =3D pdev->dev.of_node;
>> + struct sio_data *sio;
>> + struct dma_device *dma;
>> + int nchannels;
>> + int err, i;
>> +
>> + err =3D of_property_read_u32(np, "dma-channels", &nchannels);
>> + if (err || nchannels > NCHANNELS_MAX)
>> + return dev_err_probe(&pdev->dev, -EINVAL,
>> +      "missing or invalid dma-channels property\n");
>> +
>> + sio =3D devm_kzalloc(&pdev->dev, struct_size(sio, channels, =
nchannels), GFP_KERNEL);
>> + if (!sio)
>> + return -ENOMEM;
>> +
>> + platform_set_drvdata(pdev, sio);
>> + sio->dev =3D &pdev->dev;
>> + sio->nchannels =3D nchannels;
>> +
>> + sio->base =3D devm_platform_ioremap_resource(pdev, 0);
>> + if (IS_ERR(sio->base))
>> + return PTR_ERR(sio->base);
>> +
>> + sio->rtk =3D devm_apple_rtkit_init(&pdev->dev, sio, NULL, 0, =
&sio_rtkit_ops);
>> + if (IS_ERR(sio->rtk))
>> + return dev_err_probe(&pdev->dev, PTR_ERR(sio->rtk),
>> +      "couldn't initialize rtkit\n");
>> + for (i =3D 1; i < SIO_NTAGS; i++)
>> + init_completion(&sio->tags.completions[i]);
>> +
>> + dma =3D &sio->dma;
>> + dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>> + dma_cap_set(DMA_CYCLIC, dma->cap_mask);
>> +
>> + dma->dev =3D &pdev->dev;
>> + dma->device_free_chan_resources =3D sio_free_chan_resources;
>> + dma->device_tx_status =3D sio_tx_status;
>> + dma->device_issue_pending =3D sio_issue_pending;
>> + dma->device_terminate_all =3D sio_terminate_all;
>> + dma->device_synchronize =3D sio_synchronize;
>> + dma->device_prep_dma_cyclic =3D sio_prep_dma_cyclic;
>> + dma->device_config =3D sio_device_config;
>> +
>> + dma->directions =3D BIT(DMA_MEM_TO_DEV);
>> + dma->residue_granularity =3D DMA_RESIDUE_GRANULARITY_SEGMENT;
>> + dma->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>> +        BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>> +        BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> +
>> + INIT_LIST_HEAD(&dma->channels);
>> + for (i =3D 0; i < nchannels; i++) {
>> + struct sio_chan *siochan =3D &sio->channels[i];
>> +
>> + siochan->host =3D sio;
>> + siochan->no =3D i;
>> + siochan->vc.desc_free =3D sio_tx_free;
>> + INIT_WORK(&siochan->terminate_wq, sio_terminate_work);
>> + vchan_init(&siochan->vc, dma);
>> + }
>> +
>> + writel(CPU_CONTROL_RUN, sio->base + REG_CPU_CONTROL);
>> +
>> + err =3D apple_rtkit_boot(sio->rtk);
>> + if (err)
>> + return dev_err_probe(&pdev->dev, err, "SIO did not boot\n");
>> +
>> + err =3D apple_rtkit_start_ep(sio->rtk, EP_SIO);
>> + if (err)
>> + return dev_err_probe(&pdev->dev, err, "starting SIO endpoint\n");
>> +
>> + err =3D sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_START));
>> + if (err < 1) {
>> + if (err =3D=3D 0)
>> + err =3D -ENXIO;
>> + return dev_err_probe(&pdev->dev, err, "starting SIO service\n");
>> + }
>> +
>> + err =3D sio_send_dt_params(sio);
>> + if (err < 0)
>> + return dev_err_probe(&pdev->dev, err, "failed to send boot-up =
parameters\n");
>> +
>> + err =3D sio_alloc_shmem(sio);
>> + if (err < 0)
>> + return err;
>> +
>> + err =3D dma_async_device_register(&sio->dma);
>> + if (err)
>> + return dev_err_probe(&pdev->dev, err, "failed to register DMA =
device\n");
>> +
>> + err =3D of_dma_controller_register(pdev->dev.of_node, =
sio_dma_of_xlate, sio);
>> + if (err) {
>> + dma_async_device_unregister(&sio->dma);
>> + return dev_err_probe(&pdev->dev, err, "failed to register with =
OF\n");
>> + }
>> +
>> + return 0;
>> +}
>> +
>> +static int sio_remove(struct platform_device *pdev)
>> +{
>> + struct sio_data *sio =3D platform_get_drvdata(pdev);
>> +
>> + of_dma_controller_free(pdev->dev.of_node);
>> + dma_async_device_unregister(&sio->dma);
>> + return 0;
>> +}
>> +
>> +static const struct of_device_id sio_of_match[] =3D {
>> + { .compatible =3D "apple,sio", },
>> + { }
>> +};
>> +MODULE_DEVICE_TABLE(of, sio_of_match);
>> +
>> +static struct platform_driver apple_sio_driver =3D {
>> + .driver =3D {
>> + .name =3D "apple-sio",
>> + .of_match_table =3D sio_of_match,
>> + },
>> + .probe =3D sio_probe,
>> + .remove =3D sio_remove,
>> +};
>> +module_platform_driver(apple_sio_driver);
>> +
>> +MODULE_AUTHOR("Martin Povi=C5=A1er <povik+lin@cutebit.org>");
>> +MODULE_DESCRIPTION("Driver for SIO coprocessor on Apple SoCs");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> --=20
>> 2.38.3
>=20
> --=20
> ~Vinod


