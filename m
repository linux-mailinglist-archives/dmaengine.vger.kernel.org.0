Return-Path: <dmaengine+bounces-7396-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB4C94268
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF8AB349A02
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DF311C31;
	Sat, 29 Nov 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="COHonWtp"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF33112BD;
	Sat, 29 Nov 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432277; cv=fail; b=occaxruIlkVO3ipqRSsMAKoVZj4/bxZwpfIG/a+Ew+LZgyPAS9eZqgr0HjmxE2lLgdXLcW1LGECSjJtizrqwOpW1sK1GIdRyQ7yQdNen/HQK9zBnKOHq/kmNQTKXUPKN/HsWMAR/5Rjiu7/HfFvjKFARjNj/A1qxeiNN4MBvUa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432277; c=relaxed/simple;
	bh=Qpq4BeOGn2njey3QkEvjF7pUY5ny3+GVqzrylataK5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnNu5Umm9QtCu+V+e5wsbb2AB07Zfl7JO+fZLvnuQh2bTLRCr/n2lUc59VuygDa99A8IlyOqnur8PjSrGrJyw/KOlWSN4gREjUQFD9DI892wMgK9b/8YAW39Fr9vWOFHVsc5C2Jbp+K7C6orNBcjyM+zA5HeLIaDf17gtFkHsAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=COHonWtp; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgL6rkpZgEAec76yoFfmpl5TTQedl87bw5IpmWuY+SRGb2igezm7JRPB+5j0PdMG/omc1RDwq1YEfLmx8fMFg5KJzk0DnIgPcgMXs1Ul1lxTyBRkpBlePyeP5qfjA1AgYXxzf2vkclCxjXQFfb/MN12JileTUvAew1ILlEtV2CaT6zKx1dbVBKaBQftYevLT+4021n4saNpLGr34EJzHsEvvgCgttNYOf41CWhIqxkgUjsJcUi0GS6GGCHOhxFBWcOePH7exf1nQvbO+clLLhDZ4KBVmKUQ1Dv2V73hcgEtpznvopEqEuDKdRuwLIs5EN5HrCDDoW9Qou8+7yvoGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIiMQxg3/ZmJcL326dWFACRmvygslm+egtJ0ikxYh1Q=;
 b=tOtPNVK6//DW5faFfWmZrE5FWPBt0swaW3K979rJ41uiZpMXAqcZcg69qH9U1IudYieELPudgVtR/r8wDWWvXXfCTKpX+M/LQBnSuIMosF3rfYIFpTKSifsmKBRkCvVEffPscrNKaFllsoZxLFYomu+QeRyrZrRCGv8PtuIUuSAvvycdULAn2fJhYqTJRe52I0NFP4NelEyGKmlA63+roY/Yo6oScc7l54Z/IEeTsMciI13oEmquVd73HYAFeR521NI8bgt+UEoWEZk+LoI8UYGQ5sXYpdUedMAwfQ0GWZl1aclJxv6mQardLz4U7BMqGAzi4/SCRY0WF60MuEPucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIiMQxg3/ZmJcL326dWFACRmvygslm+egtJ0ikxYh1Q=;
 b=COHonWtpZ2t/N3CHHN1gkPKkEZ3hE2wJKAb8gv7Vqme5U+EBAhQnhFovonjktCEptLwm15JuW4aB4vJnZmV9gGB00+D86MgEE/wVGiuafIUKtsyZpfV1npCT097P452ofY1IOafn+9T/CVWwq1hfa3lly9Dj9ndI716+6V63zCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:29 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:29 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 11/27] NTB: epf: vntb: Implement .get_pci_epc() callback
Date: Sun, 30 Nov 2025 01:03:49 +0900
Message-ID: <20251129160405.2568284-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c3914f-b680-4f01-8820-08de2f60fa3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxghey0OgEfZsR5ySe3ZKnFEbWxRF+l78vnClXoBuV/1ahwfHipG3RWvg0QM?=
 =?us-ascii?Q?PUD6F9cR1ihuAIWLjbTeB5hevEEuAoNOrRwEGs/eZ9zeZ1iCfDwxkPtvBsKG?=
 =?us-ascii?Q?Nv7AiAosmh1kY5VAeruu/pG4eygv8yXOpc7ZYzu9Zrw2bjGwj0sS+xik2W2W?=
 =?us-ascii?Q?jDI/LWG3qXYtpYHLv2xoU3Mb+cbsm+8GlQf46gvz7k/hRjcX9yQn+vNEILmR?=
 =?us-ascii?Q?wJsykF2YJb6jkSwBE6Hv6S7dg1v3TOhVmR/YUjG88aFenjei0cz3HvQZ2DHy?=
 =?us-ascii?Q?BZmbGAwlRNhjeqMd98GOwjqWq08doC5mE6bc0wfyj5rf+k4o+92eqXOvrqsG?=
 =?us-ascii?Q?Ger0iLYFFqSS5Pmlj+DwQr0u/w5HfTFXeo/kJ9wn6Snj5Ssc+0kcvYkvpYw9?=
 =?us-ascii?Q?Y4CYKFvcxEvsPJllKgfcNxEWTydbyrozaEMZMY8ER6y+EUqqKoVO7oNV0VUK?=
 =?us-ascii?Q?57h2wa5FaVJm8e7XZWLoPYr0BCSNzHcLPZyD41j+CpkTGMBnxB8fkiy5QmJ7?=
 =?us-ascii?Q?nurBTFwjYhGM9pElLAjfW3jBxsMFLd0BagZ9ULbpTH+e2oLxulrev/fupyjD?=
 =?us-ascii?Q?AQxagEiAo5vQXWlZ9TDqQDQpD7phGadRfWD5T1RS6j48vg3tkHlGN2lFAj7F?=
 =?us-ascii?Q?u97wrnQMw9RZAspSUy3/3IOgbGZg7w5mXzTdKp9SpPCXgxYi7kx+36zRDbn5?=
 =?us-ascii?Q?Fd0qxJNPcqdmofnP/SAQmsHA/0mnbAVDEujFKwsV7AK2I5k/uyoQkWDEqsLs?=
 =?us-ascii?Q?6R7g2Zw5e1YzTaGZVhiBPwufzgtdTiPf/3dmFtfP4qxS96iGYoQDIDraJBFz?=
 =?us-ascii?Q?nLCxg/EWd2pWeuduWmaZW752mjJXvOz2OnVt+6eaeOygiAu6otUZQIcQs73q?=
 =?us-ascii?Q?cFUo5Vd4iMYb0TdYnVVjeoofhbEvYNQE91Xf/ZlFAS7UtoumWxkuXH40aNXf?=
 =?us-ascii?Q?zCx1FXRGmmy8QSqdJXlzeGuvTgupBH2YCbujkkvpSmf8rLFAq06Lukw+QBrR?=
 =?us-ascii?Q?AjL3mIRBtQKmDbSpY+U8iEcgHqTEE4ShfMuy5AMoWsMUnvia11sTd6OTC9Kg?=
 =?us-ascii?Q?V8IaF4fhlvPo7F7N6GLXNvwpPn3CMj+EqKemiEHK/3CaJetQQZs/wgLECoww?=
 =?us-ascii?Q?SCluaNc35IdMVxMrDFjuXgM8MbRRsbqCxh91oQBir935F+msZrQiOEncQrE2?=
 =?us-ascii?Q?TpwwjQvV5BtMRUIlDW4EbO/y14xq7C+/Qx1eD7DPS0pVSqCzvwIJzyW9xYDw?=
 =?us-ascii?Q?DeE+h7LPWzIeyzdQIkLqlv+Q/9AgEtjDttqI2/O7x/EBb6TMDb2QEEPiYK59?=
 =?us-ascii?Q?2fysMJnvQ21eCzaC1xmOvBNXGm79mWfvzf+7AZCk8sAqqUlL+8mzlDoS0ZbT?=
 =?us-ascii?Q?3KSbbq0WiuluS9AadonJ2X5JHy3Z+0xZ3UhIGb761z/l4YuD9sv/vi9ISSOK?=
 =?us-ascii?Q?bsa3SkfsWq7MJbQXlSyEIlXeNGFeQnQS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q52KofhlgkOgXRqCfod9dcL6L4GPvh5EyG+XCFiuhaEHGWQKGEOVBrwBTnMF?=
 =?us-ascii?Q?G/5sC/HzvXFCtkh2vghRIr+KJNMNFa9D6HBJe7IKp5smMBvdlnDCYhWTbK/c?=
 =?us-ascii?Q?/qw1pig39LP0F926pt974mOOC1ur5w+iiR688emh/ONsM2kmMUzuyRBoOtV+?=
 =?us-ascii?Q?oO2QUU6KiD1PquzRL4hw2orNoh24p+VcM9x8ccqFIzZl888C3z8xTY+ZVmog?=
 =?us-ascii?Q?bWudRqQsnInOjHoEBGQE0AwPCK0WR4uYglnAghp8qhQv7qnpzsYU5A9yw5Ox?=
 =?us-ascii?Q?aDXKBBVLUnLJffPjDpDu5r54x99XIiF2nlxsiDqWQJlAz/AT9k8NGco3hN1L?=
 =?us-ascii?Q?dy4Xve5jyZclDYAPknk9dwwiXEwTnBo04NweRMNRnh6cpB/uejSlVyroN36M?=
 =?us-ascii?Q?AxW54JvLLxHikTGHai/rYSFNtLJxpUrjmMQzREWFZQhxyoZxTtQlaAXPOYw5?=
 =?us-ascii?Q?v/RVuXtvHUbHUXPVcxNKMuJpzCfuYpKchM2INzvpcq+GmFFLKTWwFSh8W7k6?=
 =?us-ascii?Q?+4w85F7lWa5hVlxNPdnIe8c2UyTc4lETv5NZsnlp/AOdfsSfpQjzKLBZcCLf?=
 =?us-ascii?Q?6z59Bi74iZI9swZHvTPNo0BN8InqZfocNi4Z4aHBe+RoTyUuEzCAIMDe3MXb?=
 =?us-ascii?Q?Y22/8ncxkXO8iLphUcQkk/0jM8GCkkKnl5y9XEFJMaCSsAcTksb2r5BFF5aM?=
 =?us-ascii?Q?qB/6V/SBwwzhIrLdXaaCeoYrAgk33HXqcbxjbjVDUW434Wzgwu6ehhWjImc3?=
 =?us-ascii?Q?ewgap0UqeuKJktUSNybsiOnAKioeJXPi/9d1ojVlzZrVpzAtrfZdZsIQivCm?=
 =?us-ascii?Q?R3NwfghcLGwVgzu3tw1Is87fmAcCJt6rVcLSAHsYd4mVJWynIS2mXcDOgC0q?=
 =?us-ascii?Q?9CxMD+twuNdrRMypM31EpgVIjhGLSZarPlY1+NWcQSBUc8fQNMSbFknu0Vjn?=
 =?us-ascii?Q?ek2SJxEqOpi3ZdvH5YITWvkUihnXgsOd9+L1hhVbFzU63GYsnoBFwP1fb4+t?=
 =?us-ascii?Q?58V/cG97KqThHC98Yi74NFI7gQc1B588aC+oZ8EAhDTB7NKHUPiYzVcOiw4W?=
 =?us-ascii?Q?fY0I63Na4rruwuH/DGjZFnGC8oIUVDg42j5QOKUftbFyfIsdNQV/z1KBbIaH?=
 =?us-ascii?Q?FpsP9hw/2oRLhlFZ6hCfbpGyUA1F/ogVN1R+WpnU2iWkAHVV9pXTedfpm4Ai?=
 =?us-ascii?Q?tkExbf1kfeXUXgp1Kc9bRoWI+QwVAZo3dArAg8X2zxxrb5PNpBMkHfefQg4E?=
 =?us-ascii?Q?CIXCdDRTh4MRKCtX31aPyXGOOZbNvEVSOtkVtRFXbkMswqbUKxuKhbsG0iNI?=
 =?us-ascii?Q?3GTKW+kPAoGPAstvVkZ9eqfQjCl6KSw05915vBBC4SRFvtU8GKagy4LfBL7Z?=
 =?us-ascii?Q?m2Z0uYXC5Fv+pRIJs5MlC+Sk2uzZxeHPKLrD/aF+OlEbEeh80pvqB35rbnYe?=
 =?us-ascii?Q?mVNGH16EjpzKqZb6anlCeg8Dlh6MJZqp+oDbuPnaP27AAeIzD887oAp2utAf?=
 =?us-ascii?Q?lxArCy13r/i/rXnuZOcduSGh0hrWQXBiZxiVrXYza1hn+oWrMKj+0whN7oyM?=
 =?us-ascii?Q?xL0tiCOrj+HHNONOiextaWJgRSPnwgrdzw3i4ttyWnK09tTc/ZNblrG1zNcW?=
 =?us-ascii?Q?HlPwWtAp1wzshAkAl9xRgxg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c3914f-b680-4f01-8820-08de2f60fa3d
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:29.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjzRyIaEnR3mG4nF0jo81NDE06QPw0BwFw46w+P9UfJP1jSoa90butqR0Zzb5jqeiRXYLMnTbZQb1lwNl5X0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Implement the new get_pci_epc() operation for the EPF vNTB driver to
expose its associated EPC device to NTB subsystems.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index aa44dcd5c943..93fd724a8faa 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1561,6 +1561,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
+static struct pci_epc *vntb_epf_get_pci_epc(struct ntb_dev *ntb)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	if (!ndev || !ndev->epf)
+		return NULL;
+	return ndev->epf->epc;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
 	.mw_count		= vntb_epf_mw_count,
 	.spad_count		= vntb_epf_spad_count,
@@ -1582,6 +1591,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_clear_mask		= vntb_epf_db_clear_mask,
 	.db_clear		= vntb_epf_db_clear,
 	.link_disable		= vntb_epf_link_disable,
+	.get_pci_epc		= vntb_epf_get_pci_epc,
 };
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.48.1


