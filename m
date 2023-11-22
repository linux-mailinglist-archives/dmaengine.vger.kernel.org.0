Return-Path: <dmaengine+bounces-167-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7D97F4197
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06411C208C6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBEF3D98B;
	Wed, 22 Nov 2023 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76DCC9D;
	Wed, 22 Nov 2023 01:27:26 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.120])
	by gateway (Coremail) with SMTP id _____8AxEvB7yV1lfuM7AA--.52566S3;
	Wed, 22 Nov 2023 17:27:23 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.120])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3y92yV1lMF5JAA--.31241S2;
	Wed, 22 Nov 2023 17:27:20 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Yingkun Meng <mengyingkun@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v5 0/2] New driver for the Loongson LS2X APB DMA Controller
Date: Wed, 22 Nov 2023 17:27:09 +0800
Message-Id: <cover.1700644483.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx3y92yV1lMF5JAA--.31241S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur43WFW7JFyDJw1Utw1kWFX_yoW8Zw1kpF
	W3WayakF1jqFyxCrs3J348ur1av3WfJ39xWa9xA34DZay7Cr12v3yfKa1qvFW7CFWIgFWj
	vFZ3GFyUCFnFyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU

Hi all:

This patchset introduces you to the LS2X apbdma controller.

The Loongson LS2X APB DMA controller is available on Loongson-2K chips.
It is a single-channel, configurable DMA controller IP core based on the
AXI bus, whose main function is to integrate DMA functionality on a chip
dedicated to carrying data between memory and peripherals in APB bus
(e.g. nand).

Thanks.

----
V5:
patch(2/2):
 - Rebase on dmaengine/next;
 - Annotate struct ls2x_dma_sg with __counted_by;
 - .remove()->.remove_new();
 - Drop duplicate assignments in ls2x_dma_chan_init().

Link to V4:
https://lore.kernel.org/all/cover.1691647870.git.zhoubinbin@loongson.cn/

V4:
patch(2/2)
  - Drop linux/of_device.h;
  - Meaningful parameter name for ls2x_dma_fill_desc(): i->sg_index; 
  - Check the slave config and reject invalid configurations;
  - Update data width handle;
  - Use generic xlate: of_dma_xlate_by_chan_id().

Link to V3:
https://lore.kernel.org/dmaengine/cover.1689075791.git.zhoubinbin@loongson.cn/

V3:
patch(1/2)
  - Add clocks property;
  - Drop dma-channels property, for we are single-channel dmac.
patch(2/2)
  - Add clk support. 

Link to V2:
https://lore.kernel.org/dmaengine/cover.1686192243.git.zhoubinbin@loongson.cn/

V2:
patch(1/2)
  - Minor changes from Conor;
  - Add Reviewed-by tag.
patch(2/2)
  - Fix build errors from lkp@intel.com.

Link to V1:
https://lore.kernel.org/dmaengine/cover.1685448898.git.zhoubinbin@loongson.cn/

Binbin Zhou (2):
  dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
  dmaengine: ls2x-apb: new driver for the Loongson LS2X APB DMA
    controller

 .../bindings/dma/loongson,ls2x-apbdma.yaml    |  62 ++
 MAINTAINERS                                   |   7 +
 drivers/dma/Kconfig                           |  14 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/ls2x-apb-dma.c                    | 705 ++++++++++++++++++
 5 files changed, 789 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
 create mode 100644 drivers/dma/ls2x-apb-dma.c

-- 
2.39.3


