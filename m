Return-Path: <dmaengine+bounces-1429-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BD87F17E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6349CB23580
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809165A4CD;
	Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BkJhVflk"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91659159;
	Mon, 18 Mar 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794734; cv=fail; b=RxL6yYlzxEQSVdlLeW6gns7oBKFfNINCx2pK7zMM9+GWyjcrtdUteHzcb90aQB5XZkN7GP26wvlLT/sP8eYTrGYV1J79yX1t0i2JKsX7LHrLBFiutENXa7FS21EHbNJlliDk/KJdUfcuuZ70DSK3vj3E5jC7iBk/j0ST922xor0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794734; c=relaxed/simple;
	bh=w3/LnRmOby3DOaAX14fhu0J2aAP8MxFdhxfkIy4OS0k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iyp/WzoNrn10sOODMfGcg04bxt8Az7HAyUAsjUfKjJKIHQGH1thyp+GZ6XW+vRo/IrooSPNb/YQ1Pso4DMYI0DlbTjicU6cD3LjSDfi5lLe4ascNFz4mrxmy1gtWPPglLgz895dIdxtF5gjZvi9HTaauCE60tQYC8COqiaYSVyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BkJhVflk; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc+p/6jLL7I7y57Ijz2II7mqyoD77TJxqFoxWwfbFHS9yq4jxIxgbqUrNQga/6Razab0HaoWXPOHdGyTDiAFJ0R5VYWRw5oSfcq9tE92w0SfmKVZlSf65sUh8H65RTyO5nzYUAhGptvrlqyIguUMcjVvvJON92S+wW0SY6Lg79PcknDgh8MvJlMr/THXUcgBjId6nxHCtnIHKw/kaEbdnNAChs9jE0rw3uJE86f+VYjEm9o0IfhaAJwMova9wvVb/KRE4nxJxj+c+elUzjC/hVXVOel0e/8AgIa89+iYvm3AYOT08ncTz08BliTR+fe+DBOmuXMSXRWDSy3+Vlkisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOqlssOfhHPLSNxPWLykgfHC201TbPMyJDi1TZaFm7I=;
 b=UmlujVcpxernAe/i2/Eop06fRU2mdOunNRsS0furykz5FV64KYvxWzGNmguaYQKWhPuwSx6FFSA13i6ubHPE8mI1urztRBkqBXBqWMu27542Z1jF52v6sBx6lS/3lz8bf+RM5GviGgWTE9RKVldKlHmiH2ReGUb9cGXH7IXH/OwDbx6G0hpWl2h37zludtJMtF2Q9sf92L6KTP31Q9yGgndmVNmZpJozaoIGmtMwlIucNvNJmxsHcQ3V4JeQvNLhHlLxPGW4us2Nhj4zC83Ja4r0FHek97vJSFh7JCTw6b3HX0bI6+4EsmM19jfWIASm75cRY5kLUYcsgSAtSisuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOqlssOfhHPLSNxPWLykgfHC201TbPMyJDi1TZaFm7I=;
 b=BkJhVflkgR6wQuh9dhjzIL6PqL1oFjn/N9se7y2uCaYmR3lXcT1gAu1rdVIBTQk5v4jN/8hp0qtrHrdPX7C5Sdmv/BQ9DTXdyMJJFRNHpPDJnVuaXVEvw80BXCNN72kWoeRjpwe/w75AXXuJ9dJ4zFsC5DA6HFU4nva8yh7u+Ws=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:45:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:45:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 16:44:37 -0400
Subject: [PATCH v3 4/5] dt-bindings: fsl-imx-sdma: Add I2C peripheral types
 ID
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-sdma_upstream-v3-4-da37ddd44d49@nxp.com>
References: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
In-Reply-To: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710794703; l=778;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=w3/LnRmOby3DOaAX14fhu0J2aAP8MxFdhxfkIy4OS0k=;
 b=bqPNETnT9g9dCP/pKfaAD7ADAsHhM/K4UKbvnGAx/OE96s65uKafW6AIojZH7OAByh9Zoszl3
 +qFuPnEq8AMAreSr65RI4ggNYOSrMdMlPEaUH+Vc+1WjCYgW79sT3qI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F7A/WelmNt67Aef/5gONx9UlhSQ7dcatufZb1Tcvnx6qWQAw8tLq6v+yqEqhZWkQcLnwqFof+wvLtEr1AB9Aeu6D72d8b5oaKOPRLuvJVAfG6nQ2ySgnrEBaBsycZ04yhTUwAftnwGmRmO0H6J7KT+TSLZimNnuj5V7a97hNFqYKsAwxVgulktCqNbvto7V9/7WP5tHDDXLz8axnPGpwpxDGTQl3+43+3BkPmhbB/MyO5KR77saKnD0ELcSbPm6OydGjloRCYjegl/jT6K+yHZX5/H06oeBw3eJtKUS3GFbwHVl6ubbpuvkoeBXttS4+eUDcbFHiM4BPaineWqngs8brP+/IJrpQBebm+nDQ+wRBf1o3bqaD9ma2X82OruTZZJ8Ro6XXWU8NN7U9qUamgPgWJLrtuEjhzyBSTkJizBJ/bhb6FtTAzx1STMgpQXl0kcCO1puFlEawrVsHmg6KoFseWIWeKb5gNm83+CZEySBL2RQouc2X8zqtFvMntm7NYePtOGyd5iN3pXJYp+9oEognL30AOl8nqk9w7PXwYMHkHNr5OGgCFJYUKqZ25ZO63on3SeW72eGcbiAqc+V4lqHkJoJ5cTB1Kkry/Kd4xCZxZ9GiEAAsF04j9eLQ23hMlzaVhB468Utmwo03LyqKTLO/DWOihVUKRnlKhhQJ6oJyhBIZlJkwRiJ1JxQCUPJTAN6YXTowtnC+XsxmP9s9L2bmbFHk45Ybvq0as1ZIu78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZ6YW5ZZjVjL2RIT29TNTBVQ1dUQkpxNExGdWtqVmcyVWlzN1hYVkwrK25Z?=
 =?utf-8?B?bzlkMmJ2elV1bzZCK3hEcTlQWnVoYjVtMUhJNWtCMTAyYlUyYVF4R25vQlVV?=
 =?utf-8?B?L0krS1E2R1dnWnlGblUyemQzbmlpZ2Q0aTM1TkRQUVkvQ3lNUUNVUDZ4QW01?=
 =?utf-8?B?RXh6a1RBT0t0cDRMam1KYURzVk9MLzhQNnBqdkk4TFRMRkUzcjdkKzVZWTJP?=
 =?utf-8?B?SUNWODM4VHUzTm1DNDI1MjNtelFvcUJ0cmdmTHBtMDhvcmllOVROcVliOFhY?=
 =?utf-8?B?VjZSZ3VoQXVsNFFDdnJKdG04RTVDR2VadU1oYjNaVFAwOEgwME1Sd1Zmd2RM?=
 =?utf-8?B?RVpWNXVEb0ZtemVrYjRlQ1pXNUlDV3VQWlAxL3lySFJtY0dtSkRjaVRjRWxQ?=
 =?utf-8?B?U1JTSk0xeVVQMFhYMVZ0cEhjakdFamx1aTJYQWVOajNmU2IraTVuNGRrL0VI?=
 =?utf-8?B?NjA3TU5IcU1SckVVR0NaQzRnMzhVMUQ2QUY0N00vNytRWGRXRFUvaUo2cmJ5?=
 =?utf-8?B?ZE4rUnFDSDhVNDA0NU85UVpRZ2t0SVkyb2VnN01nMFg5RnhmM24wWnIxWG9B?=
 =?utf-8?B?WU9rZExJRzZpQTFZZkJKZXdLUkpYUUN5SnEvcW93UHo3SkJQdnRqU25KelIy?=
 =?utf-8?B?dWVob0gxRzczTldaZVZSRXdmbTNJdjBnMytlOEJjSytlNlFGSDN1MUJrWS8z?=
 =?utf-8?B?aG93dStyOXFRWUZPZmkrYWxvRmt3WmFMMHpwRlNFSUMyZHZRWVhLNjRNQ2dG?=
 =?utf-8?B?QXlCcTd4REViS0QyMkFPcnd4cUVobVYyV3k3KzlybEx3Rnh5VXAyWklIN28v?=
 =?utf-8?B?MEJsTUg3N0JQUVFBZDhmM0M4bGFIVWNDeUlncG9uS3BITDRwTWpFNmhQbDVC?=
 =?utf-8?B?WiswMTFHK0xvc1UyQ2FKZ01Ba2lpWGZpTi9rSEFQZElxaU0vVU1PYUJZbkFm?=
 =?utf-8?B?TTExUHNOMUI3bG1EaFo5cWtKclVGNUpYZEpYMUFkZXZsZkZObU1LVVN4cEpE?=
 =?utf-8?B?R3V4NUdGYVdlRWp0Y09va0Y1eWhFdVdxNG9xUXVQcWtjZlRHTjRuQzU2TGY1?=
 =?utf-8?B?UjNtTmZOSVVLL3dYcE10OE43SVB2ZzVTSzA1YW5hWlBLVXRXMHRrUVYzL3Bt?=
 =?utf-8?B?NWdNbSsvWDFxdGdpMzBEQzNTM2ozS2tzYTQ3dnByc0JxWm1zUlJKQWYyek9P?=
 =?utf-8?B?K1VIRTM3dXNjeTVHZ0JDUkp2YzZxZ1Q4OFJMK294RTRmUzVIOUtYalNINzVj?=
 =?utf-8?B?RWl1UTBTT1lIZE83MUE4VlNjNldDd0FCNVhQd2FoQ0JyRlYxM2VkdUY1RkNV?=
 =?utf-8?B?UWlXS2dxVk5BUlpiNDlVb3lsOG5uWmVLNnhlOWQzYzBVTFFsWXc0M2V5ZGZT?=
 =?utf-8?B?RkZOM0NvOUVSWW1YMUFESnBTSlVCekdLUjRScTAxMExEU3NzbStMaDZWVTgw?=
 =?utf-8?B?emtCRmtkNjRJWHZqNEV0b1FSZTJrb0JKdXR0RjhpYmMwWWh1KzR3a1BLWXY3?=
 =?utf-8?B?cHV3eFFOb2UrZnExd0t3QTlDanpVTlpMcFZOQVlCb2NRR1JVdzhhTjgrYWk4?=
 =?utf-8?B?eDJRWHg4QnZ6eWdrU0IwQzRsbExWU2wwNExEaWFRQkFKTWRYTHM3anV3cGxD?=
 =?utf-8?B?T21pYVVvOGNyWFY5bU5LS05XWWF2dGZLbEEwQ2tpM0pBMnRIdjZLZ1hZczI0?=
 =?utf-8?B?cXI5RjJqK3BBN1J1cm9tclBiWE95YTZqMmhXeTQ5dC9CejZIQTR3NjB0bWtR?=
 =?utf-8?B?cm1vVVZXUUNMcUFCZ0d1K1R6NDJEcVBLaEQ5NWQwNWljb3pvNHlwSUhjUGJM?=
 =?utf-8?B?a1l5TnI4YnFzSVJPZDNubGg5OWJhL3gvMlFWK0FweFBYVDBVSW4wck9BZFRz?=
 =?utf-8?B?UU5POHNhVzcxYXk0SEJsQk96cHRqS2psNEVITGF2UURZRWR6NjhTVG9adUlq?=
 =?utf-8?B?R3VrUE9XSlZIbHp5QjNtSC9HUFZVZ2NUQWdnUmsxM2RGYUVoejFiUnVGeEQ2?=
 =?utf-8?B?b1o3eHQzaXVmSmhkL2xqcGVLSXFZQ2I5UTVERThhTHRWbVAwNXBjdGV5VUY4?=
 =?utf-8?B?aUxRZXRhREpDVi9LL3A4ZzNjUVg4TWJYdk4rM0Q3TTBHZ1lqSE1Nd1VBLzBI?=
 =?utf-8?Q?IDJa6f6CyuHoatxbJzR4fgi7s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c886d0-9354-4a75-fbda-08dc478c5785
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:45:26.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmA5PyZyZiQikAP+2bgy3QpK0N5261f0YRUhqfKGryZfNaLEUbApSJS+7cs093Zjbaldd3WHz/4dMTozWhfiRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

Add peripheral types ID 26 for I2C because sdma firmware (sdma-6q: v3.6,
sdma-7d: v4.6) support I2C DMA transfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
index b95dd8db5a30a..80bcd3a6ecaf3 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -93,6 +93,7 @@ properties:
           - Shared ASRC: 23
           - SAI: 24
           - HDMI Audio: 25
+          - I2C: 26
 
        The third cell: transfer priority ID
          enum:

-- 
2.34.1


