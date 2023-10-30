Return-Path: <dmaengine+bounces-13-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31447DC031
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 20:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC70B20B31
	for <lists+dmaengine@lfdr.de>; Mon, 30 Oct 2023 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707DD529;
	Mon, 30 Oct 2023 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="lc07Nrme"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B0D2F8
	for <dmaengine@vger.kernel.org>; Mon, 30 Oct 2023 19:01:37 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8856D9F;
	Mon, 30 Oct 2023 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1698692486; x=1699297286; i=rwahl@gmx.de;
	bh=RL+2Jj7yTa1YkQxwQqBk1lDJpWOcvMAibeGmceC7PFM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=lc07Nrme33vaEJXATGrCrZLPUnO1jMXAgKct4TXWqfYjUV1C6sB+3s6VrkpU8X13
	 1n1zPaidYaM1YcwIm3D+v5isXKpDgQav3cTqUZDhpwQztla+XI30/OfkKHMwllrsY
	 ILQkn9dKG3fMVw7Ob4K4OLY8mBgJCoNjXyk8if3UBEXeGmDRaUJuWMiB8cGLSkkp6
	 o3KcowWxJ8X5UU47CACC+Iw9grfbZvn2WY8bNC3AP2al0NqOnDr0bkZRfYkLFQ6tO
	 xIW2EA1oanFS9S8NITGaGJsV1ILGFx7lffbCmf6I0+So1g1SWOsgPhkrrIAwL2pl6
	 nlwQgfYHJCFDkzph1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1rkXbE3lwT-00udmR; Mon, 30
 Oct 2023 20:01:25 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] dmaengine: ti: k3-psil-am62: Fix SPI PDMA data
Date: Mon, 30 Oct 2023 20:01:13 +0100
Message-ID: <20231030190113.16782-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L6kLIsHeklRFkUTiQk+CeqdX3lShBysPO12BdwFKntNStilMnjz
 hnsGJW4Qn43v3qIjUp8GOMJg09tmgPvClz3yJCok/hMpUBNZWKJ1FhLkVpJ1GjNUHY1zqrp
 9nlZuRP1sCkXab4aVXZO5sCAGiLShZeMLGTf/UToLgG63huU/m6yHrnCGvic0YixwriqKhf
 o2710fiSp2nRoiDkskllQ==
UI-OutboundReport: notjunk:1;M01:P0:x7yBYD442zw=;lf1QeWTjOrGoH8GY43dxnSi3Gvd
 ZuSJcQwdndewF1fdfn4JaPPzIwmmwR5XaRRd+MKpHNzVgYAIRZaZZopeKVWRFIyDqOo0IzfZZ
 fw/11pktrtIXGtNCDPu/b6J5lkH3GNCUJ/C/mEEEarldfDM40TGU1zyXb5gOZjGUSVDPO7Pia
 WcHoeda0XWHNA5EAzKrfrwuFoQWECa0PaF//A2OLrWjSN+0+XXDUOLB6uSzAxRhjhJAIFORZj
 88N6wZWVMLV0W3VYFKgOi59/jam2cTsgUKIwnJqyamDDr7zYMklqjUvzyDvTSAtS2PPhObi1d
 TB3WCNTzUqdUBZenXgGZvI74YNeHzMqoLqM1gb3cWGBUZq02TFwsOH9zkZelb9XJgMQZf/MT1
 OFPxj3YDZxdfIoml0cqzUIdZ2ee42TM2GcFWA3CiPhxUVEZkGknNFrJK8XhrW6Z2cWABqdJJa
 JxsRHKKwxpXCkQhCoIqQvf72MDy7eQgg6WB7ZVm0zy5OI03WxXEix9u7d57yVphXQtZzH0uxY
 Q4PdmWZrQeKNmj/CE3SCnFMNXkXnQEvd9ehze78uEaJclADYxIpTrnX8f5Ziq9z72cv20kffK
 z3G4r4qBVwtgotBrMMepgIMYlNQQY0CwHtOk7ohieC4czV+h908zw4Ex9wmm3NTWmzntNOT4j
 pYQGJYCeOW/JrMZToTAm+OyXBYVuARi7jeOdQY8/E32VC61yIjMge+LiDJwjFeBNDdY1/+JYh
 jQOgG5+LpfrboGQuBee1KU6fo2IgWvill01jeEKtcBJ0utQhMfcbxRM80E3gmuUrWfpz4jOUJ
 025ydRYqw2M7+LTszeHCtzvywIv8PQNAXANsEf/dsUnSdRHHs9QQI/bBBUBSj6X2Fp+krZ+KO
 obs7rYwx3C6mLBonoDFWLG9HTr6+SQWeOAbSuutawaX29l2QbpBtXak1QCFH5fFhKTHQpds6I
 JdRmRXhnCv3PFsPj0zWSWtbUn0M=

AM62x has 3 SPI channels where each channel has 4 TX and 4 RX threads.
This also fixes the thread numbers.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/dma/ti/k3-psil-am62.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
index 2b6fd6e37c61..1272b1541f61 100644
=2D-- a/drivers/dma/ti/k3-psil-am62.c
+++ b/drivers/dma/ti/k3-psil-am62.c
@@ -74,7 +74,9 @@ static struct psil_ep am62_src_ep_map[] =3D {
 	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
 	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
 	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0x4300),
+	PSIL_PDMA_XY_PKT(0x4301),
 	PSIL_PDMA_XY_PKT(0x4302),
 	PSIL_PDMA_XY_PKT(0x4303),
 	PSIL_PDMA_XY_PKT(0x4304),
@@ -85,8 +87,6 @@ static struct psil_ep am62_src_ep_map[] =3D {
 	PSIL_PDMA_XY_PKT(0x4309),
 	PSIL_PDMA_XY_PKT(0x430a),
 	PSIL_PDMA_XY_PKT(0x430b),
-	PSIL_PDMA_XY_PKT(0x430c),
-	PSIL_PDMA_XY_PKT(0x430d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0x4400),
 	PSIL_PDMA_XY_PKT(0x4401),
@@ -141,7 +141,9 @@ static struct psil_ep am62_dst_ep_map[] =3D {
 	/* SAUL */
 	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
 	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
-	/* PDMA_MAIN0 - SPI0-3 */
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0xc300),
+	PSIL_PDMA_XY_PKT(0xc301),
 	PSIL_PDMA_XY_PKT(0xc302),
 	PSIL_PDMA_XY_PKT(0xc303),
 	PSIL_PDMA_XY_PKT(0xc304),
@@ -152,8 +154,6 @@ static struct psil_ep am62_dst_ep_map[] =3D {
 	PSIL_PDMA_XY_PKT(0xc309),
 	PSIL_PDMA_XY_PKT(0xc30a),
 	PSIL_PDMA_XY_PKT(0xc30b),
-	PSIL_PDMA_XY_PKT(0xc30c),
-	PSIL_PDMA_XY_PKT(0xc30d),
 	/* PDMA_MAIN1 - UART0-6 */
 	PSIL_PDMA_XY_PKT(0xc400),
 	PSIL_PDMA_XY_PKT(0xc401),
=2D-
2.41.0


