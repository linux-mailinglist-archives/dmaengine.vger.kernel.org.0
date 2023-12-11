Return-Path: <dmaengine+bounces-467-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB380D8DC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 19:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24063281E97
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A151C50;
	Mon, 11 Dec 2023 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NU6LdAur"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59AB4;
	Mon, 11 Dec 2023 10:49:19 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BBBp5DM026654;
	Mon, 11 Dec 2023 19:48:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=y0BmSNYVc0wIoHagTE06vyC2a0PPdmZEKhzR/LzDmMc=; b=NU
	6LdAuryyO6Ga1iwo5fQKJ4qt9KbKn770wj6T3gOQHQH8X5YbAp1+UV3/jhMHhLrs
	cf5mSXZ+UTzH0IXqI3h/LIIq5QIYYW0JPDmAqjQUc1aPNF0Ma3JyG/rrVmHw4NIS
	i641bFyjuG8jMIKmysY4F/IOKWvTkxue2uVsKSDu9/se3G4zEsNkFwInrwuVGRTj
	cwRV24hHks2klsL1XGlPPhAQIeOHuwrnpM9F9zvKVUUCKQjmj+FFHa1Y5jCuEL1K
	15E0I2+Dq2va+7kSS2LAGto2F1rUuEr4bHq8oJ+8C739i5sAghX5YEM2SwfrphHm
	4ltMRuMz9SbyWhuVmt6A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvgf1g1sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 19:48:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70B9010005C;
	Mon, 11 Dec 2023 19:48:09 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34D44252238;
	Mon, 11 Dec 2023 19:48:09 +0100 (CET)
Received: from [10.252.9.5] (10.252.9.5) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Dec
 2023 19:48:07 +0100
Message-ID: <719399bd-273d-40b5-b512-59a2e09ddbf8@foss.st.com>
Date: Mon, 11 Dec 2023 19:48:02 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] Introduce STM32 Firewall framework
Content-Language: en-US
To: <Oleksii_Moisieiev@epam.com>, <gregkh@linuxfoundation.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <vkoul@kernel.org>, <jic23@kernel.org>, <olivier.moysan@foss.st.com>,
        <arnaud.pouliquen@foss.st.com>, <mchehab@kernel.org>,
        <fabrice.gasnier@foss.st.com>, <andi.shyti@kernel.org>,
        <ulf.hansson@linaro.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <hugues.fruchet@foss.st.com>, <lee@kernel.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <arnd@kernel.org>,
        <richardcochran@gmail.com>, Frank Rowand <frowand.list@gmail.com>,
        <peng.fan@oss.nxp.com>, <lars@metafoo.de>, <rcsekar@samsung.com>,
        <wg@grandegger.com>, <mkl@pengutronix.de>
CC: <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-media@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20231211183044.808204-1-gatien.chevallier@foss.st.com>
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20231211183044.808204-1-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_08,2023-12-07_01,2023-05-22_02

Hi,

I messed up when squashing.

I did not restore the ETZPC/RIFSC "simple-bus" compatible for stm32mp15
and stm32mp25 SoC device trees.

I apologize for this inconvenience and will resend the patchset with
this compatible correctly restored.

Best regards,
Gatien

On 12/11/23 19:30, Gatien Chevallier wrote:
> Introduce STM32 Firewall framework for STM32MP1x and STM32MP2x
> platforms. STM32MP1x(ETZPC) and STM32MP2x(RIFSC) Firewall controllers
> register to the framework to offer firewall services such as access
> granting.
> 
> This series of patches is a new approach on the previous STM32 system
> bus, history is available here:
> https://lore.kernel.org/lkml/20230127164040.1047583/
> 
> The need for such framework arises from the fact that there are now
> multiple hardware firewalls implemented across multiple products.
> Drivers are shared between different products, using the same code.
> When it comes to firewalls, the purpose mostly stays the same: Protect
> hardware resources. But the implementation differs, and there are
> multiple types of firewalls: peripheral, memory, ...
> 
> Some hardware firewall controllers such as the RIFSC implemented on
> STM32MP2x platforms may require to take ownership of a resource before
> being able to use it, hence the requirement for firewall services to
> take/release the ownership of such resources.
> 
> On the other hand, hardware firewall configurations are becoming
> more and more complex. These mecanisms prevent platform crashes
> or other firewall-related incoveniences by denying access to some
> resources.
> 
> The stm32 firewall framework offers an API that is defined in
> firewall controllers drivers to best fit the specificity of each
> firewall.
> 
> For every peripherals protected by either the ETZPC or the RIFSC, the
> firewall framework checks the firewall controlelr registers to see if
> the peripheral's access is granted to the Linux kernel. If not, the
> peripheral is configured as secure, the node is marked populated,
> so that the driver is not probed for that device.
> 
> The firewall framework relies on the access-controller device tree
> binding. It is used by peripherals to reference a domain access
> controller. In this case a firewall controller. The bus uses the ID
> referenced by the access-controller property to know where to look
> in the firewall to get the security configuration for the peripheral.
> This allows a device tree description rather than a hardcoded peripheral
> table in the bus driver.
> 
> The STM32 ETZPC device is responsible for filtering accesses based on
> security level, or co-processor isolation for any resource connected
> to it.
> 
> The RIFSC is responsible for filtering accesses based on Compartment
> ID / security level / privilege level for any resource connected to
> it.
> 
> STM32MP13/15/25 SoC device tree files are updated in this series to
> implement this mecanism.
> 
> Changes in V7:
> 	- Separate indentation changes from access-controllers changes
> 	  in the device tree file commits
> 	- Select OF_DYNAMIC when STM32_FIREWALL is set in order to use
> 	  of_detach_node() in the firewall framework
> 	- Handle previously non-present RNG and HASH nodes in the
> 	  STM32MP13 device tree file
> 
> Changes in V6:
> 	- Rename access-controller to access-controllers
> 	- Remove access-controller-provider
> 	- Update device trees and other bindings accordingly
> 	- Rework ETZPC/RIFSC bindings to define what access-controllers
> 	  cells contain inside #access-controller-cells
> 	- Some other minor fixes
> 
> Changes in V5:
> 	- Integrate and rework the "feature-domains" binding patch in
> 	  this patchset. The binding is renamed to "access-controller"
> 	- Rename every feature-domain* reference to access-control*
> 	  ones
> 	- Correct loop bug and missing select STM32_FIREWALL in 32-bit
> 	  platform Kconfig
> 	
> 
> Changes in V4:
> 	- Fix typo in commit message and YAML check errors in
> 	  "dt-bindings: Document common device controller bindings"
> 	  Note: This patch should be ignored as stated in the cover
> 	  letter. I've done this to avoid errors on this series of
> 	  patch
> 	- Correct code syntax/style issues reported by Simon Horman
> 	- Added Jonathan's tag for IIO on the treewide patch
> 
> Changes in V3:
> 
> 	Change incorrect ordering for bindings commits leading
> 	to an error while running
> 	"make DT_CHECKER_FLAGS=-m dt_binding_check"
> 
> Changes in V2:
> 
> 	generic:
> 		- Add fw_devlink dependency for "feature-domains"
> 		  property.
> 
> 	bindings:
> 		- Corrected YAMLS errors highlighted by Rob's robot
> 		- Firewall controllers YAMLs no longer define the
> 		  maxItems for the "feature-domains" property
> 		- Renamed st,stm32-rifsc.yaml to
> 		  st,stm32mp25-rifsc.yaml
> 		- Fix examples in YAML files
> 		- Change feature-domains maxItems to 2 in firewall
> 		  consumer files as there should not be more than
> 		  2 entries for now
> 		- Declare "feature-domain-names" as an optional
> 		  property for firewall controllers child nodes.
> 		- Add missing "feature-domains" property declaration
> 		  in bosch,m_can.yaml and st,stm32-cryp.yaml files
> 
> 	firewall framework:
> 		- Support multiple entries for "feature-domains"
> 		  property
> 		- Better handle the device-tree parsing using
> 		  phandle+args APIs
> 		- Remove "resource firewall" type
> 		- Add a field for the name of the firewall entry
> 		- Fix licenses
> 	
> 	RIFSC:
> 		- Add controller name
> 		- Driver is now a module_platform_driver
> 		- Fix license
> 
> 	ETZPC:
> 		- Add controller name
> 		- Driver is now a module_platform_driver
> 		- Fix license
> 
> 	Device trees:
> 		- Fix rifsc node name
> 		- Move the "ranges" property under the
> 		  "feature-domains" one
> 
> Gatien Chevallier (12):
>    dt-bindings: treewide: add access-controllers description
>    dt-bindings: bus: document RIFSC
>    dt-bindings: bus: document ETZPC
>    firewall: introduce stm32_firewall framework
>    of: property: fw_devlink: Add support for "access-controller"
>    bus: rifsc: introduce RIFSC firewall controller driver
>    arm64: dts: st: add RIFSC as an access controller for STM32MP25x
>      boards
>    bus: etzpc: introduce ETZPC firewall controller driver
>    ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
>    ARM: dts: stm32: put ETZPC as an access controller for STM32MP15x
>      boards
>    ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards
>    ARM: dts: stm32: put ETZPC as an access controller for STM32MP13x
>      boards
> 
> Oleksii Moisieiev (1):
>    dt-bindings: document generic access controllers
> 
>   .../access-controllers.yaml                   |   84 +
>   .../bindings/bus/st,stm32-etzpc.yaml          |   87 +
>   .../bindings/bus/st,stm32mp25-rifsc.yaml      |   96 +
>   .../bindings/crypto/st,stm32-cryp.yaml        |    4 +
>   .../bindings/crypto/st,stm32-hash.yaml        |    4 +
>   .../devicetree/bindings/dma/st,stm32-dma.yaml |    4 +
>   .../bindings/dma/st,stm32-dmamux.yaml         |    4 +
>   .../devicetree/bindings/i2c/st,stm32-i2c.yaml |    4 +
>   .../bindings/iio/adc/st,stm32-adc.yaml        |    4 +
>   .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  |    4 +
>   .../bindings/iio/dac/st,stm32-dac.yaml        |    4 +
>   .../bindings/media/cec/st,stm32-cec.yaml      |    4 +
>   .../bindings/media/st,stm32-dcmi.yaml         |    4 +
>   .../memory-controllers/st,stm32-fmc2-ebi.yaml |    4 +
>   .../bindings/mfd/st,stm32-lptimer.yaml        |    4 +
>   .../bindings/mfd/st,stm32-timers.yaml         |    4 +
>   .../devicetree/bindings/mmc/arm,pl18x.yaml    |    4 +
>   .../bindings/net/can/bosch,m_can.yaml         |    4 +
>   .../devicetree/bindings/net/stm32-dwmac.yaml  |    4 +
>   .../bindings/phy/phy-stm32-usbphyc.yaml       |    4 +
>   .../bindings/regulator/st,stm32-vrefbuf.yaml  |    4 +
>   .../devicetree/bindings/rng/st,stm32-rng.yaml |    4 +
>   .../bindings/serial/st,stm32-uart.yaml        |    4 +
>   .../bindings/sound/st,stm32-i2s.yaml          |    4 +
>   .../bindings/sound/st,stm32-sai.yaml          |    4 +
>   .../bindings/sound/st,stm32-spdifrx.yaml      |    4 +
>   .../bindings/spi/st,stm32-qspi.yaml           |    4 +
>   .../devicetree/bindings/spi/st,stm32-spi.yaml |    4 +
>   .../devicetree/bindings/usb/dwc2.yaml         |    4 +
>   MAINTAINERS                                   |    7 +
>   arch/arm/boot/dts/st/stm32mp131.dtsi          | 1063 ++++---
>   arch/arm/boot/dts/st/stm32mp133.dtsi          |   51 +-
>   arch/arm/boot/dts/st/stm32mp13xc.dtsi         |   19 +-
>   arch/arm/boot/dts/st/stm32mp13xf.dtsi         |   19 +-
>   arch/arm/boot/dts/st/stm32mp151.dtsi          | 2756 +++++++++--------
>   arch/arm/boot/dts/st/stm32mp153.dtsi          |   52 +-
>   arch/arm/boot/dts/st/stm32mp15xc.dtsi         |   19 +-
>   arch/arm/mach-stm32/Kconfig                   |    1 +
>   arch/arm64/Kconfig.platforms                  |    1 +
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |    6 +-
>   drivers/bus/Kconfig                           |   10 +
>   drivers/bus/Makefile                          |    1 +
>   drivers/bus/stm32_etzpc.c                     |  141 +
>   drivers/bus/stm32_firewall.c                  |  294 ++
>   drivers/bus/stm32_firewall.h                  |   83 +
>   drivers/bus/stm32_rifsc.c                     |  252 ++
>   drivers/of/property.c                         |    2 +
>   include/linux/bus/stm32_firewall_device.h     |  141 +
>   48 files changed, 3351 insertions(+), 1938 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
>   create mode 100644 Documentation/devicetree/bindings/bus/st,stm32-etzpc.yaml
>   create mode 100644 Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml
>   create mode 100644 drivers/bus/stm32_etzpc.c
>   create mode 100644 drivers/bus/stm32_firewall.c
>   create mode 100644 drivers/bus/stm32_firewall.h
>   create mode 100644 drivers/bus/stm32_rifsc.c
>   create mode 100644 include/linux/bus/stm32_firewall_device.h
> 

