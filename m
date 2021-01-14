Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71FA2F6C05
	for <lists+dmaengine@lfdr.de>; Thu, 14 Jan 2021 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbhANU0n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Jan 2021 15:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbhANU0m (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 Jan 2021 15:26:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D9A323406;
        Thu, 14 Jan 2021 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610655961;
        bh=24IcesIZAJJ9vh00NnenYmnWgbIvDJFLhYvq4Zl0XaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qUkH+iUvTBTCB8mCHO7OLoxT5V/mrMaUCQ43o710mTStOfo+VUVVKabvCaej52FJR
         B4A5y+5YsW6/glqSU+U/+09LrHY38ZumOUrr2d7gO5UDAMufE/HIDdvH/6DxnmJYSN
         0OcDhLOrkUiHcogdyetkVX5vL8SXHiJ5Fa6rC1xQRj/Y1hpVUYOIxfXHh8SWU/ifdV
         tRinwHiu8eS8FqMH7kxRnRdLRBtSq4TGxH4SpCKtZHusL2+l+HxTn+p+9THDV9i1QV
         Yn44gkYWdDK7onMvjLKLM3B79SyuUqXl+n7oS5MNeweFZnskUUZ17RfqdDU55RMUYQ
         gOE7a+a/sftdA==
Received: by mail-ed1-f52.google.com with SMTP id b2so7141681edm.3;
        Thu, 14 Jan 2021 12:26:01 -0800 (PST)
X-Gm-Message-State: AOAM5311Vbcdm64dXE3LOzFht7wwveoT3s8P503xLmckEKyLJPP9WQgV
        G14HdBjAMwZTe2kD9OoIFsOqJlCYhHLx6l91hA==
X-Google-Smtp-Source: ABdhPJzcwbGcnTL917yh9ibb7k4vvsd76xGrOhcvG0k6RiQqszTsitz37X3r0bUyKLdQXXHRa+UlvyNESjSeKi07Ojg=
X-Received: by 2002:a05:6402:352:: with SMTP id r18mr6888792edw.373.1610655960013;
 Thu, 14 Jan 2021 12:26:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608090736.git.mallikarjunax.reddy@linux.intel.com> <dee2d43dff26f7d5b6eaa0006659da254f1093d3.1608090736.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <dee2d43dff26f7d5b6eaa0006659da254f1093d3.1608090736.git.mallikarjunax.reddy@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Jan 2021 14:25:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE59nA_Bvt1rL95WfeXjQkOSPiTZk8zAbdHSkujmS3gQ@mail.gmail.com>
Message-ID: <CAL_JsqJE59nA_Bvt1rL95WfeXjQkOSPiTZk8zAbdHSkujmS3gQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v10 1/2] dt-bindings: dma: Add bindings for Intel
 LGM SoC
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Vinod <vkoul@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        chuanhua.lei@linux.intel.com,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>, malliamireddy009@gmail.com,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 15, 2020 at 10:08 PM Amireddy Mallikarjuna reddy
<mallikarjunax.reddy@linux.intel.com> wrote:
>
> Add DT bindings YAML schema for DMA controller driver
> of Lightning Mountain (LGM) SoC.
>
> Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v1:
> - Initial version.
>
> v2:
> - Fix bot errors.
>
> v3:
> - No change.
>
> v4:
> - Address Thomas langer comments
>   - use node name pattern as dma-controller as in common binding.
>   - Remove "_" (underscore) in instance name.
>   - Remove "port-" and "chan-" in attribute name for both 'dma-ports' & 'dma-channels' child nodes.
>
> v5:
> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child nodes to dma client/consumer side as cells in 'dmas' properties.
>
> v6:
> - Add additionalProperties: false
> - completely removed 'dma-ports' and 'dma-channels' child nodes.
> - Moved channel dt properties to client side dmas.
> - Use standard dma-channels and dma-channel-mask properties.
> - Documented reset-names
> - Add description for dma-cells
>
> v7:
> - modified compatible to oneof
> - Reduced number of dma-cells to 3
> - Fine tune the description of some properties.
>
> v7-resend:
> - rebase to 5.10-rc1
> - No change.
>
> v8:
> - rebased to 5.10-rc3
> - Fixing the bot issues (wrong indentation)
>
> v9:
> - Use 'enum' instead of oneOf+const
> - Drop '#dma-cells' in required:, already covered in dma-common.yaml
> - Drop nodename Already covered by dma-controller.yaml
>
> v10:
> - rebased to 5.10-rc6
> - Add Reviewed-by: Rob Herring <robh@kernel.org>
> - Fixed typo.
> - moved property dma-desc-in-sram to driver side.
> - Moved property dma-orrc to driver side.
>
> v10-resend:
> - rebased to 5.10
> - No change
> ---
>  .../devicetree/bindings/dma/intel,ldma.yaml   | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> new file mode 100644
> index 000000000000..866d4c758a7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lightning Mountain centralized DMA controllers.
> +
> +maintainers:
> +  - chuanhua.lei@intel.com
> +  - mallikarjunax.reddy@intel.com
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,lgm-cdma
> +      - intel,lgm-dma2tx
> +      - intel,lgm-dma1rx
> +      - intel,lgm-dma1tx
> +      - intel,lgm-dma0tx
> +      - intel,lgm-dma3
> +      - intel,lgm-toe-dma30
> +      - intel,lgm-toe-dma31
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 3
> +    description:
> +      The first cell is the peripheral's DMA request line.
> +      The second cell is the peripheral's (port) number corresponding to the channel.
> +      The third cell is the burst length of the channel.
> +
> +  dma-channels:
> +    minimum: 1
> +    maximum: 16
> +
> +  dma-channel-mask:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: ctrl
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  intel,dma-poll-cnt:
> +    $ref: /schemas/types.yaml#definitions/uint32

Since this was sent, there have been some fixes for JSON pointers and
this is missing a '/'. The tools now check:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/dma/intel,ldma.yaml:
properties:intel,dma-poll-cnt: 'oneOf' conditional failed, one must be
fixed:
 'enum' is a required property
 'const' is a required property
 '/schemas/types.yaml#definitions/uint32' does not match
'types.yaml#/definitions/'

Please send a fix for this.

Thanks,
Rob
