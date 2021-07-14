Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2544B3C7B49
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhGNCHU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:07:20 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:19970
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237371AbhGNCHT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9iWKtDKzqE2B2kxh+4MMdjSpEQHWC9W/YP1WQdaygCQl8nMIYgWudXUEcnimPd/RpxzveyoPFrYS8abL/sQNBshEspGsFr12l9yadwGFBJ8SJBi/ejMdgNGZTeRBm6qrxyc4p58TAgX87rKF03qOY2vzaYtnidN3cteMU+rjIAba9uugigr/Lkxcgmu7D1mhnMYjMhmx3JV4QgGvWowznbtPOTvM+iFcV3q3+JH1r5JPAOr1gQMQumD8fBTk4nNbGXXE1NmOpYtdozs4drSo6UxZQPVBJcruGuJ76bsejqJBYqkcjgdIPqffAZx5VbNKydxm0vhB4Z2iTnIaYMJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCp/jBq2deIKOpO2zAiCC7KNlDLWpTkEwsmJnPrQa5Q=;
 b=ge1lHNeoL7/pbhOcwvkxZi9d5BxVVP2wAOnCkzdjt8SMhH7YIchBIIo7CnHEMNtgnPqWpl8YpaMSQhpZ2+FcqzIKLJOSdlzJwD7JC7yesU3/eOZXnrnSFl+baahk5YUjwIVPo3xvRf9xG7YW0ECygthyT8/7vehfJy3te0VHGTEHTa/TfO6SYUaH8uR1DepahhILJAR8c0P/BrP7styLT4JKyliNAae2nRQI6ITTr8OJ46SW5r+wMp4dHSBVj2MP9W6womBghhAB4q6Ffj/DcqtdLwKx48WmnfYQtw9wqbZnxsGNXotGCqN0hAiZiNbP0Dhr3cKK8naHCsKoG/eYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCp/jBq2deIKOpO2zAiCC7KNlDLWpTkEwsmJnPrQa5Q=;
 b=Z8vq6pz4O3rk56To7aj83PuKK31Euh16K5xq/2Adr2OC5V84ZASx/u0+DYFW6iXvvULEDx6d0mew5380eMtlF3/dASsPg9RQJdDyd4cfGXMh8IGTyeYrMT4KdRQtxOC1ZPcmASogr+RAQz3Y8l6cu0K2Z0T/QTwJdLXidkrpVaU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:04:26 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:04:26 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Date:   Wed, 14 Jul 2021 18:20:40 +0800
Message-Id: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:04:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 713a1dee-cfde-47c3-30ea-08d9466bb476
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4175AA42E36FE3446DBE337F89139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GsvKMJOrgtLZUBof3ffycTVGUbEvDd+93zwoqjBVbhC/se3rLY5aVimt1PVdx348PYvBNiToxmDG3R3WI0rZKYcXgHZzQ4BGxGCrvqoen9C4L2CD29/Zg2zAajdvOLUBoNb/b8B3UsEZkO4CwMP9I/KWo0VGMMT4Pln862JdZpczHMJaMpS5tCWrp1OyiMX4fRiUnAVKKn6umvQmVmbo/PU8hFNh7Yhe5b7QlpXsuyfeOPJIz/7y8NOn3BLxA94g9+NpaideQJI6qYwfDC6kuW9q0E7+RVRrR1JLAUmEg7Ps7uAGOmUUG4kE1xNM+rClhGsdsTuafnSP+a201ISCCY99eKbAGaJcfDWIiVMI0KX2VSRvFmLbDOCX4SOjDW3NSLMP8k8GUCT7253sIBeEuQau43nonMoOUtZmJi+Jrz5U1oGUo9PXT2OX7jXzZMN7t392g11ySIyLVxBT1FjmpSpDHZJuucFP9/DOqZ9i3rivAZXgh7rBeFBCk+/ni61oSPdIRikjBrDROH6ru+ZeNhjnPY4umGCNCuVsk1poP4/LlcJD29gWzduZS7gDT+6ULQslJR5AVxs29HeYsS+8Upg32X2dfC5UjGdvxU8R6SIIpkdrQSs2szuU5WcqfvGpPbEe0K25+lQvAY/wcScyvyFKxm+Ywla0/QE31rn/duKzp8lyTXykGlJKnGBnBECw4sZVUakbhNouklW14XNHoEupE0CLQJqYRxYUNstwvtavpchpAvqLYxAj4oBBoe4JJtdCab5hmjER6ONMpaLN1vte5IhTRyHk6+p+fMbzRjpgIKa4ONRSl/EC1UMP7LkK5fnFQf77+sEkoU2E8xSgOMLQNG5HU1aW36L0Bbb5UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(966005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxQLq7oHBaVkLmIj+oGFxW4OY3J1l9IgamWoOv9keulYGCMdURuXOUU4rWcy?=
 =?us-ascii?Q?TMw5G+vEtEWpSVs/QKHSBSIgrUjyk51+KgtOagANxpeTAAtZ0zVcA3ndAoNc?=
 =?us-ascii?Q?NhRVtVfHpLKusLu2Fk7VegO/qHBliwyl2vUeO1e+M3uUj1ovCcuNyWvdzigi?=
 =?us-ascii?Q?WrDxSEtkShS3B7QP9rGNPaIJWnGq/xOc787ZOljUU8yyobHzAMyviVVIFjUe?=
 =?us-ascii?Q?xvHwrdom/RNlqfiGl1YndZuA+WFsLlKMM+ZXM3qU0HmSb/sowr4pH2n4f2aN?=
 =?us-ascii?Q?i5Vg39JoFy9h2gwW1jx0RWz9pXVIldT4TEOPXCMcMFr/Pe1NmkOoqlkyOeIE?=
 =?us-ascii?Q?3CzeM0tx0AXBuWNq2qwEOUeROnsSGQDIHmY1XNDji0p/VzOLt5i5INsV7mbs?=
 =?us-ascii?Q?FvLkABLxx9LgyRDvAaLJ/DQpPLcPOJMpL/jkKp70iN9Xk5vHECprmcKhHzAz?=
 =?us-ascii?Q?41eEUq2pjgq6oHerQgGaqWsscUfCvOZBjtfxtg7hxOK34gMaSUyZLdix3aO8?=
 =?us-ascii?Q?yH0emlLak+wFWLn7hKJFxOj02YJY8GAyQJX6xgLqNDBg01HvreYUjtqkTTpq?=
 =?us-ascii?Q?dnrNSHA+Wy7/qq5mxMJVm2A6xlsFs1qDo2rfd4FHhKhKGDjYc7EqyaXLq5q9?=
 =?us-ascii?Q?Qz+rmBr8z13T6vMTvZLOuT8rKcPMltsVsY1lSVguZuNMNAK96q2PFIgFbZRj?=
 =?us-ascii?Q?IknOIDKpfx5+zQVGgtN1dLVozgApj+flafEiiWnV/S1pAJy/yNagYmBnlmuI?=
 =?us-ascii?Q?3ndVEPgkxbIJXYGx2Va+LIqy/nRr1jjdxgj6b9CmzKIVrQB1mcnhF9CkrBFf?=
 =?us-ascii?Q?rb13X56W9EHiORMWeGFyi13EeNU4PjBw49vkIY4x5XAHzT2Btd1cngm1Ufvm?=
 =?us-ascii?Q?s/f+Soa0DVBid4D28+ts7uL9xrM0D769dEZEstenTqFnxPF4YjCcmgJi3uWm?=
 =?us-ascii?Q?j+tAEcsK9WlUJuHJrxRfHZ3GAfpETIE1JeR53ImtdlTFG1joReheqp94Vz2d?=
 =?us-ascii?Q?ovuWeH3tiY7ebO/ev1NWvhj5OeqvGuxwlsETPQVEasGiMMHqv/6pkLnSgqd0?=
 =?us-ascii?Q?9rVRWamKLhrbAD45ITK4mNKEX5wWQFGFJ0HSPMWyP56eV6vq0fhS9lk3KAfu?=
 =?us-ascii?Q?A669KxYk8Hp4W63IqtTfHLgnTi5v0UmxWm982mKWo8cUMnCuITO8He+4m38L?=
 =?us-ascii?Q?ERugIL/xLzUY8BgQxiT8stkbyQc+fBPPiTjQqtsLvDayfBRmbTcc0K+v+QUk?=
 =?us-ascii?Q?tlL4Y5XRlrcgAAU1aYvT5eYrMEpsVEN+1EpsxsB02ScPkN7DBDOYSSgLA3al?=
 =?us-ascii?Q?tWwIRgILvMTa7J17Xg/16xjd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a1dee-cfde-47c3-30ea-08d9466bb476
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:04:25.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49YhRb3UgVIsjfdJD/dSiNd24TDA1wU0x273NrqBriApr0zRnEcwuEBFqTYUw8clfu4cC1L68dVz/j7p4bmdBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
transfer to be send twice in DMA mode. Please get more information from:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
new sdma ram script which works in XCH  mode as PIO inside sdma instead
of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
exist on all legacy i.mx6/7 soc family before i.mx6ul.
NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
or not.
The first two reverted patches should be the same issue, though, it
seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
have the chance to test this patch set if could fix their issues.
Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
on i.mx8mm because the event id is zero.

PS:
   Please get sdma firmware from below linux-firmware and copy it to your
local rootfs /lib/firmware/imx/sdma.
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

v2:
  1.Add commit log for reverted patches.
  2.Add comment for 'ecspi_fixed' in sdma driver.
  3.Add 'fsl,imx6sll-ecspi' compatible instead of 'fsl,imx6ul-ecspi'
    rather than remove.
v3:
  1.Confirm with design team make sure ERR009165 fixed on i.mx6ul/i.mx6ull
    /i.mx6sll, not fixed on i.mx8m/8mm and other i.mx6/7 legacy chips.
    Correct dts related dts patch in v2.
  2.Clean eratta information in binding doc and new 'tx_glitch_fixed' flag
    in spi-imx driver to state ERR009165 fixed or not.
  3.Enlarge burst size to fifo size for tx since tx_wml set to 0 in the
    errata workaroud, thus improve performance as possible.
v4:
  1.Add Ack tag from Mark and Vinod
  2.Remove checking 'event_id1' zero as 'event_id0'.
v5:
  1.Add the last patch for compatible with the current uart driver which
    using rom script, so both uart ram script and rom script supported
    in latest firmware, by default uart rom script used. UART driver
    will be broken without this patch.
v6:
  1.Resend after rebase the latest next branch.
  2.Remove below No.13~No.15 patches of v5 because they were mergered.
  	ARM: dts: imx6ul: add dma support on ecspi
  	ARM: dts: imx6sll: correct sdma compatible
  	arm64: defconfig: Enable SDMA on i.mx8mq/8mm
  3.Revert "dmaengine: imx-sdma: fix context cache" since
    'context_loaded' removed.
v7:
  1.Put the last patch 13/13 'Revert "dmaengine: imx-sdma: fix context
    cache"' to the ahead of 03/13 'Revert "dmaengine: imx-sdma: refine
    to load context only once" so that no building waring during comes out
    during bisect.
  2.Address Sascha's comments, including eliminating any i.mx6sx in this
    series, adding new 'is_imx6ul_ecspi()' instead imx in imx51 and taking
    care SMC bit for PIO.
  3.Add back missing 'Reviewed-by' tag on 08/15(v5):09/13(v7)
   'spi: imx: add new i.mx6ul compatible name in binding doc'
v8:
  1.remove 0003-Revert-dmaengine-imx-sdma-fix-context-cache.patch and merge
    it into 04/13 of v7
  2.add 0005-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch for no any
    ecspi function broken even if sdma firmware not updated.
  3.merge 'tx.dst_maxburst' changes in the two continous patches into one
    patch to avoid confusion.
  4.fix typo 'duplicated'.
v9:
  1. add "spi: imx: add dma_sync_sg_for_device after fallback from dma"
     to fix the potential issue brought by commit bcd8e7761ec9("spi: imx:
     fallback to PIO if dma setup failure") which is the only one patch
     of v8 merged. Thanks Matthias for reporting:
     https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com/
  2. remove 05/13 of v8 "spi: imx:fallback to PIO if dma setup failure"
     since it's been merged.
v10:
  1. remove 01/13 "spi: imx: add dma_sync_sg_for_device after fallback from dma"
     since there is another independent patch merged:
     -- commit 809b1b04df898 ("spi: introduce fallback to pio")
  2. add "dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script" which
     is used to fix the potential dma_alloc_coherent() failure while this
     patchset applied but sdma firmware may not be ready for long time.
  3. burst size change back from fifo size to normal wml to align with nxp
     internal tree which has been test for years. Overnight with loopback
     test with spidev failed with fifo size, but pass with wml(half of fifo
     size).Seems the whole fifo size fed may cause rxfifo overflow during
     tx shift out while rx shift in.
     "spi: imx: remove ERR009165 workaround on i.mx6ul"
  4. remove 12/13 'dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm'
     since below two similar patches merged:
     -- commit 25962e1a7f1d ("dmaengine: imx-sdma: Fix the event id check to
     include RX event for UART6")
     -- commit 2f57b8d57673 ("dmaengine: imx-sdma: Fix: Remove 'always true'
     comparison")
v11:
  1. change dev_err() to dev_warn_once() in case sdma firmware not loaded to
     eliminate meaningless duplicate log print.
v12:
  1. take care uart_2_mcu_addr/uartsh_2_mcu_addr since such rom scripts are
     now located in the bottom part of sdma_script_start_addrs which are beyond
     the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1. Reported by Frieder as below:
     https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2263544.html
v13:
  1. rebase with latest linux-next.
  2. remove 09/12 'spi: imx: add new i.mx6ul compatible name in binding doc'
     since it's been converted to yaml already.
  3. add 'Fixes', 'Cc: stable@vger.kernel.org' and 'Test-by' tags for 03,04
     since they are confirmed fix by Richard Leitner:
     https://lkml.org/lkml/2020/8/17/39
     https://www.spinics.net/lists/dmaengine/msg23489.html
  4. fix potential descriptor free unexpected on the next transfer before
     the last channel terminated:
     https://www.spinics.net/lists/dmaengine/msg23400.html
v14:
  1. rebase with latest linux-next.

v15:
  1. reuse IMX51_ECSPI type instead of new IMX6UL_ECSPI driver.
  2. use mcu_2_app rom script directly instead of ram script on i.mx6ul.

v16:
  1. move 'sdmac->is_ram_script = false' from sdma_config_write() to
     sdma_get_pc() for addressing Lucas's concern.

Robin Gong (12):
  Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
  Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
  Revert "dmaengine: imx-sdma: refine to load context only once"
  dmaengine: imx-sdma: remove duplicated sdma_load_context
  dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
  dmaengine: imx-sdma: add mcu_2_ecspi script
  spi: imx: fix ERR009165
  spi: imx: remove ERR009165 workaround on i.mx6ul
  dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
  dma: imx-sdma: add i.mx6ul compatible name
  dmaengine: imx-sdma: add uart rom script
  dmaengine: imx-sdma: add terminated list for freed descriptor in
    worker

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  8 +-
 drivers/dma/imx-sdma.c                             | 93 ++++++++++++++++------
 drivers/spi/spi-imx.c                              | 41 ++++++++--
 5 files changed, 111 insertions(+), 34 deletions(-)

-- 
2.7.4

